import 'package:dartz/dartz.dart';
import '../entities/path_node.dart';
import '../entities/coordinate.dart';
import '../../core/errors/failures.dart';

/// Pathfinding repository contract
/// Handles all path-related operations
abstract class PathfindingRepository {
  /// Get all path nodes in the store
  Future<Either<Failure, List<PathNode>>> getAllPathNodes();

  /// Get a specific path node by ID
  Future<Either<Failure, PathNode>> getPathNodeById(String id);

  /// Get the closest walkable node to a coordinate
  /// Used to find starting/ending points for navigation
  Future<Either<Failure, PathNode>> getClosestWalkableNode(Coordinate coordinate);

  /// Calculate navigation path using A* algorithm
  /// Returns a path from start to destination
  Future<Either<Failure, NavigationPath>> calculatePath({
    required Coordinate start,
    required Coordinate destination,
  });

  /// Add a new path node (admin only)
  Future<Either<Failure, PathNode>> addPathNode(PathNode node);

  /// Update an existing path node (admin only)
  Future<Either<Failure, PathNode>> updatePathNode(PathNode node);

  /// Delete a path node (admin only)
  Future<Either<Failure, void>> deletePathNode(String id);

  /// Create a connection between two nodes (admin only)
  Future<Either<Failure, void>> connectNodes(String nodeId1, String nodeId2);

  /// Remove a connection between two nodes (admin only)
  Future<Either<Failure, void>> disconnectNodes(String nodeId1, String nodeId2);

  /// Generate a grid of path nodes automatically (admin utility)
  /// Creates evenly spaced nodes across the map
  Future<Either<Failure, List<PathNode>>> generatePathGrid({
    required double mapWidth,
    required double mapHeight,
    required double spacing,
  });

  /// Toggle node walkability (admin only)
  /// Used to mark obstacles (shelves, walls, etc.)
  Future<Either<Failure, PathNode>> toggleNodeWalkability(String nodeId);

  /// Get path nodes in a specific area (for rendering optimization)
  Future<Either<Failure, List<PathNode>>> getPathNodesInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  });
}
