import 'package:drift/drift.dart' as drift;
import '../../domain/entities/store_map.dart' as domain;
import '../datasources/local/database.dart';

/// Data model for StoreMap
extension StoreMapModel on StoreMap {
  /// Convert database row to domain entity
  domain.StoreMap toDomain() {
    return domain.StoreMap(
      id: id,
      name: name,
      imageUrl: imageUrl,
      width: width,
      height: height,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension on domain StoreMap
extension StoreMapToDrift on domain.StoreMap {
  /// Convert domain entity to Drift companion
  StoreMapsCompanion toCompanion() {
    return StoreMapsCompanion(
      id: drift.Value(id),
      name: drift.Value(name),
      imageUrl: drift.Value(imageUrl),
      width: drift.Value(width),
      height: drift.Value(height),
      createdAt: drift.Value(createdAt),
      updatedAt: drift.Value(updatedAt),
    );
  }
}
