import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_all_products.dart';
import '../../domain/usecases/search_products.dart';
import 'database_provider.dart';

/// State for product list
class ProductListState {
  final List<Product> products;
  final bool isLoading;
  final String? error;

  const ProductListState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  ProductListState copyWith({
    List<Product>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Product list provider
class ProductListNotifier extends StateNotifier<ProductListState> {
  final GetAllProducts getAllProducts;

  ProductListNotifier(this.getAllProducts) : super(const ProductListState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await getAllProducts();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (products) => state = state.copyWith(
        products: products,
        isLoading: false,
        error: null,
      ),
    );
  }

  void refresh() => loadProducts();
}

/// Provider for product list
final productListProvider = StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  final getAllProducts = GetAllProducts(repository);
  return ProductListNotifier(getAllProducts);
});

/// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

/// Searched products provider (derived state)
final searchedProductsProvider = FutureProvider<List<Product>>((ref) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    return [];
  }

  final repository = ref.watch(productRepositoryProvider);
  final searchUseCase = SearchProducts(repository);

  final result = await searchUseCase(SearchProductsParams(query: query));

  return result.fold(
    (failure) => [],
    (products) => products,
  );
});

/// Selected product provider
final selectedProductProvider = StateProvider<Product?>((ref) => null);

/// Categories provider
final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getCategories();

  return result.fold(
    (failure) => [],
    (categories) => categories,
  );
});

/// Filter by category provider
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

/// Filtered products by category
final filteredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);

  if (category == null) {
    return [];
  }

  final repository = ref.watch(productRepositoryProvider);
  final result = await repository.getProductsByCategory(category);

  return result.fold(
    (failure) => [],
    (products) => products,
  );
});
