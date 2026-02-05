import 'package:dartz/dartz.dart';
import '../entities/store_map.dart';
import '../../core/errors/failures.dart';

/// Store map repository contract
/// Handles map image and metadata operations
abstract class MapRepository {
  /// Get the current active store map
  Future<Either<Failure, StoreMap>> getCurrentMap();

  /// Upload a new map image (admin only)
  /// Saves the image and creates metadata
  Future<Either<Failure, StoreMap>> uploadMap({
    required String imagePath,
    required String name,
    required double width,
    required double height,
  });

  /// Update map metadata (admin only)
  Future<Either<Failure, StoreMap>> updateMap(StoreMap map);

  /// Delete a map (admin only)
  Future<Either<Failure, void>> deleteMap(String id);

  /// Get all maps (for multi-floor support in the future)
  Future<Either<Failure, List<StoreMap>>> getAllMaps();
}
