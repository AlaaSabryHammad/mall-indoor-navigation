import 'package:equatable/equatable.dart';
import 'coordinate.dart';

/// Represents a walkable node in the store's pathfinding grid
/// These nodes define where customers can walk
class PathNode extends Equatable {
  final String id;
  final Coordinate position;
  final bool isWalkable;
  final List<String> connectedNodeIds;

  const PathNode({
    required this.id,
    required this.position,
    required this.isWalkable,
    required this.connectedNodeIds,
  });

  /// For A* pathfinding algorithm
  PathNode copyWithAStarData({
    double? gScore,
    double? fScore,
    PathNode? parent,
  }) {
    // These are only used during pathfinding, not stored
    return this;
  }

  PathNode copyWith({
    String? id,
    Coordinate? position,
    bool? isWalkable,
    List<String>? connectedNodeIds,
  }) {
    return PathNode(
      id: id ?? this.id,
      position: position ?? this.position,
      isWalkable: isWalkable ?? this.isWalkable,
      connectedNodeIds: connectedNodeIds ?? this.connectedNodeIds,
    );
  }

  @override
  List<Object?> get props => [id, position, isWalkable, connectedNodeIds];

  @override
  String toString() => 'PathNode(id: $id, position: $position, walkable: $isWalkable)';
}

/// Represents a calculated navigation path from start to destination
class NavigationPath extends Equatable {
  final List<Coordinate> waypoints;
  final double totalDistance;
  final Duration estimatedDuration;

  const NavigationPath({
    required this.waypoints,
    required this.totalDistance,
    required this.estimatedDuration,
  });

  /// Check if path is valid
  bool get isValid => waypoints.length >= 2;

  /// Get start coordinate
  Coordinate get start => waypoints.first;

  /// Get end coordinate
  Coordinate get destination => waypoints.last;

  /// Get number of turns in the path
  int get turnCount {
    if (waypoints.length < 3) return 0;

    int turns = 0;
    for (int i = 1; i < waypoints.length - 1; i++) {
      final prev = waypoints[i - 1];
      final current = waypoints[i];
      final next = waypoints[i + 1];

      // Calculate direction change
      final dx1 = current.x - prev.x;
      final dy1 = current.y - prev.y;
      final dx2 = next.x - current.x;
      final dy2 = next.y - current.y;

      // Check if direction changed significantly
      if ((dx1 * dx2 + dy1 * dy2).abs() < 0.9) {
        turns++;
      }
    }
    return turns;
  }

  /// Get the next waypoint after current position
  Coordinate? getNextWaypoint(Coordinate currentPosition, double threshold) {
    for (final waypoint in waypoints) {
      if (currentPosition.distanceTo(waypoint) > threshold) {
        return waypoint;
      }
    }
    return waypoints.last;
  }

  @override
  List<Object?> get props => [waypoints, totalDistance, estimatedDuration];

  @override
  String toString() => 'NavigationPath(waypoints: ${waypoints.length}, distance: $totalDistance)';
}
