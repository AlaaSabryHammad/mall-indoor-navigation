import 'package:dartz/dartz.dart';
import 'package:fuzzy/fuzzy.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/product.dart' as domain;
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/database.dart';
import '../models/product_model.dart';

/// Implementation of ProductRepository using Drift database
class ProductRepositoryImpl implements ProductRepository {
  final AppDatabase database;

  ProductRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<domain.Product>>> getAllProducts() async {
    try {
      final products = await database.getAllProducts();
      return Right(products.map((p) => p.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch products: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.Product>> getProductById(String id) async {
    try {
      final product = await database.getProductById(id);
      if (product == null) {
        return const Left(ProductNotFoundFailure('Product not found'));
      }
      return Right(product.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch product: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.Product>> getProductByBarcode(String barcode) async {
    try {
      final product = await database.getProductByBarcode(barcode);
      if (product == null) {
        return const Left(ProductNotFoundFailure('Product not found'));
      }
      return Right(product.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch product: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.Product>>> searchProducts(String query) async {
    try {
      // Get all products first
      final allProducts = await database.getAllProducts();
      final domainProducts = allProducts.map((p) => p.toDomain()).toList();

      // Use fuzzy search for better UX
      final fuzzy = Fuzzy<domain.Product>(
        domainProducts,
        options: FuzzyOptions(
          keys: [
            WeightedKey(
              name: 'name',
              getter: (domain.Product p) => p.name,
              weight: 0.5,
            ),
            WeightedKey(
              name: 'category',
              getter: (domain.Product p) => p.category,
              weight: 0.3,
            ),
            WeightedKey(
              name: 'barcode',
              getter: (domain.Product p) => p.barcode,
              weight: 0.2,
            ),
          ],
          threshold: 0.4,
        ),
      );

      final results = fuzzy.search(query);
      return Right(results.map((r) => r.item).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to search products: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.Product>>> getProductsByCategory(String category) async {
    try {
      final products = await database.getProductsByCategory(category);
      return Right(products.map((p) => p.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch products by category: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final categories = await database.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch categories: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.Product>> addProduct(domain.Product product) async {
    try {
      // Check for duplicate barcode
      final existing = await database.getProductByBarcode(product.barcode);
      if (existing != null) {
        return const Left(DuplicateBarcodeFailure('Product with this barcode already exists'));
      }

      await database.insertProduct(product.toCompanion());
      return Right(product);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add product: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.Product>> updateProduct(domain.Product product) async {
    try {
      // Convert to database product first
      final dbProduct = await database.getProductById(product.id);
      if (dbProduct == null) {
        return const Left(ProductNotFoundFailure('Product not found'));
      }

      // Create updated product
      final updatedDbProduct = dbProduct.copyWith(
        name: product.name,
        barcode: product.barcode,
        category: product.category,
        description: product.description,
        imageUrl: product.imageUrl,
        quantity: product.quantity,
        aisleNumber: product.aisleNumber,
        shelfNumber: product.shelfNumber,
        locationX: product.location.x,
        locationY: product.location.y,
        updatedAt: DateTime.now(),
      );

      await database.updateProduct(updatedDbProduct);
      return Right(updatedDbProduct.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update product: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    try {
      await database.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete product: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.Product>>> getProductsInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  }) async {
    try {
      final products = await database.getProductsInArea(
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
      );
      return Right(products.map((p) => p.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch products in area: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductQuantity(String id, int quantity) async {
    try {
      await database.updateProductQuantity(id, quantity);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update product quantity: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.Product>>> getLowStockProducts() async {
    try {
      final products = await database.getLowStockProducts();
      return Right(products.map((p) => p.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch low stock products: $e'));
    }
  }
}
