import 'package:dartz/dartz.dart';
import '../entities/user_position.dart';
import '../entities/coordinate.dart';
import '../../core/errors/failures.dart';

/// Positioning repository contract
/// Handles user location tracking
/// Currently simulated, but designed for future real positioning systems
abstract class PositioningRepository {
  /// Get current user position
  /// Returns a stream for real-time updates
  Stream<Either<Failure, UserPosition>> getPositionStream();

  /// Get current position (one-time fetch)
  Future<Either<Failure, UserPosition>> getCurrentPosition();

  /// Set simulated position (for testing and demo)
  Future<Either<Failure, void>> setSimulatedPosition(UserPosition position);

  /// Start simulated navigation from start to destination
  /// Automatically updates position along the path
  Stream<Either<Failure, UserPosition>> simulateNavigation({
    required List<Coordinate> waypoints,
    required Duration duration,
  });

  /// Initialize BLE beacon positioning (future feature)
  Future<Either<Failure, void>> initializeBLEPositioning();

  /// Initialize WiFi positioning (future feature)
  Future<Either<Failure, void>> initializeWiFiPositioning();

  /// Stop positioning updates
  Future<Either<Failure, void>> stopPositioning();

  /// Calibrate positioning system (future feature)
  /// User stands at known location to improve accuracy
  Future<Either<Failure, void>> calibratePosition(Coordinate knownPosition);
}
