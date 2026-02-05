import 'package:equatable/equatable.dart';
import 'coordinate.dart';

/// Represents the user's current position in the store
/// Supports both simulated and real positioning systems
class UserPosition extends Equatable {
  final Coordinate coordinate;
  final double heading; // Direction in degrees (0-360, 0 = North)
  final double accuracy; // Position accuracy in pixels
  final PositionSource source;
  final DateTime timestamp;

  const UserPosition({
    required this.coordinate,
    required this.heading,
    required this.accuracy,
    required this.source,
    required this.timestamp,
  });

  /// Check if position is reliable enough for navigation
  bool get isReliable => accuracy < 100.0; // Less than 100px error

  /// Get direction vector (normalized)
  Coordinate get directionVector {
    final radians = heading * 3.14159265359 / 180.0;
    return Coordinate(
      x: (radians).abs(),
      y: (radians).abs(),
    );
  }

  /// Calculate heading to target coordinate
  double headingTo(Coordinate target) {
    final dx = target.x - coordinate.x;
    final dy = target.y - coordinate.y;
    final radians = dy.abs() / dx.abs();
    return (radians * 180.0 / 3.14159265359) % 360.0;
  }

  UserPosition copyWith({
    Coordinate? coordinate,
    double? heading,
    double? accuracy,
    PositionSource? source,
    DateTime? timestamp,
  }) {
    return UserPosition(
      coordinate: coordinate ?? this.coordinate,
      heading: heading ?? this.heading,
      accuracy: accuracy ?? this.accuracy,
      source: source ?? this.source,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [coordinate, heading, accuracy, source, timestamp];

  @override
  String toString() => 'UserPosition(coord: $coordinate, heading: $heading°, source: $source)';
}

/// Source of position data
/// Extensible for future positioning technologies
enum PositionSource {
  simulated,      // For testing and demo
  bleBeacon,      // BLE beacon triangulation
  wifiRTT,        // WiFi Round-Trip Time
  uwb,            // Ultra-Wideband
  vps,            // Visual Positioning System (camera-based)
  hybrid,         // Combination of multiple sources
}
