import 'package:drift/drift.dart' as drift;
import '../../domain/entities/product.dart' as domain;
import '../../domain/entities/coordinate.dart';
import '../datasources/local/database.dart';

/// Data model for Product
/// Handles conversion between domain entity and database table
extension ProductModel on domain.Product {
  /// Convert domain entity to Drift companion (for insert/update)
  ProductsCompanion toCompanion() {
    return ProductsCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      barcode: drift.Value(barcode),
      category: drift.Value(category),
      description: drift.Value(description),
      imageUrl: drift.Value(imageUrl),
      quantity: drift.Value(quantity),
      aisleNumber: drift.Value(aisleNumber),
      shelfNumber: drift.Value(shelfNumber),
      locationX: drift.Value(location.x),
      locationY: drift.Value(location.y),
      createdAt: drift.Value(createdAt),
      updatedAt: drift.Value(updatedAt),
    );
  }
}

/// Extension to convert Drift table row to domain entity
extension ProductFromTable on drift.Product {
  /// Convert database row to domain entity
  domain.Product toDomain() {
    return domain.Product(
      id: id,
      name: name,
      barcode: barcode,
      category: category,
      description: description,
      imageUrl: imageUrl,
      quantity: quantity,
      aisleNumber: aisleNumber,
      shelfNumber: shelfNumber,
      location: Coordinate(x: locationX, y: locationY),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
