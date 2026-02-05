import 'package:equatable/equatable.dart';

/// Represents a 2D coordinate on the store map
/// Immutable value object
class Coordinate extends Equatable {
  final double x;
  final double y;

  const Coordinate({
    required this.x,
    required this.y,
  });

  /// Calculate Euclidean distance to another coordinate
  /// Used for pathfinding heuristic
  double distanceTo(Coordinate other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy).abs(); // Squared distance (faster, no sqrt needed)
  }

  /// Calculate Manhattan distance (for grid-based pathfinding)
  double manhattanDistanceTo(Coordinate other) {
    return (x - other.x).abs() + (y - other.y).abs();
  }

  /// Check if coordinate is within bounds
  bool isWithinBounds(double maxX, double maxY) {
    return x >= 0 && y >= 0 && x <= maxX && y <= maxY;
  }

  /// Linear interpolation between two coordinates
  /// Used for smooth animation
  Coordinate lerp(Coordinate other, double t) {
    return Coordinate(
      x: x + (other.x - x) * t,
      y: y + (other.y - y) * t,
    );
  }

  @override
  List<Object?> get props => [x, y];

  @override
  String toString() => 'Coordinate(x: $x, y: $y)';
}
