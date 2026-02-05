import 'package:dartz/dartz.dart';
import '../entities/product.dart';
import '../../core/errors/failures.dart';

/// Product repository contract
/// Defines all product-related operations
/// Implementation will be in data layer
abstract class ProductRepository {
  /// Get all products from the database
  /// Returns Either<Failure, List<Product>>
  Future<Either<Failure, List<Product>>> getAllProducts();

  /// Get a single product by ID
  Future<Either<Failure, Product>> getProductById(String id);

  /// Get product by barcode (for barcode scanning)
  Future<Either<Failure, Product>> getProductByBarcode(String barcode);

  /// Search products by name (supports fuzzy search)
  /// Returns products sorted by relevance
  Future<Either<Failure, List<Product>>> searchProducts(String query);

  /// Get products by category
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);

  /// Get all unique categories
  Future<Either<Failure, List<String>>> getCategories();

  /// Add a new product (admin only)
  Future<Either<Failure, Product>> addProduct(Product product);

  /// Update an existing product (admin only)
  Future<Either<Failure, Product>> updateProduct(Product product);

  /// Delete a product (admin only)
  Future<Either<Failure, void>> deleteProduct(String id);

  /// Get products within a specific area (for map rendering optimization)
  /// Returns products whose coordinates are within the specified bounds
  Future<Either<Failure, List<Product>>> getProductsInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  });

  /// Update product quantity (inventory management)
  Future<Either<Failure, void>> updateProductQuantity(String id, int quantity);

  /// Get low stock products (quantity < 10)
  Future<Either<Failure, List<Product>>> getLowStockProducts();
}
