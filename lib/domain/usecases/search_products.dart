import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case for searching products
/// Implements fuzzy search for better UX
class SearchProducts implements UseCase<List<Product>, SearchProductsParams> {
  final ProductRepository repository;

  SearchProducts(this.repository);

  @override
  Future<Either<Failure, List<Product>>> call(SearchProductsParams params) async {
    // Validate input
    if (params.query.trim().isEmpty) {
      return const Right([]);
    }

    // Delegate to repository
    return await repository.searchProducts(params.query);
  }
}

class SearchProductsParams {
  final String query;

  const SearchProductsParams({required this.query});
}
