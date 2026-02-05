import 'dart:ui' show Offset;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/coordinate.dart';
import '../../domain/entities/path_node.dart';
import '../../domain/entities/user_position.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/calculate_navigation_path.dart';
import 'database_provider.dart';

/// Navigation state
class NavigationState {
  final NavigationPath? currentPath;
  final UserPosition? currentPosition;
  final Product? destination;
  final bool isNavigating;
  final bool isLoading;
  final String? error;

  const NavigationState({
    this.currentPath,
    this.currentPosition,
    this.destination,
    this.isNavigating = false,
    this.isLoading = false,
    this.error,
  });

  NavigationState copyWith({
    NavigationPath? currentPath,
    UserPosition? currentPosition,
    Product? destination,
    bool? isNavigating,
    bool? isLoading,
    String? error,
  }) {
    return NavigationState(
      currentPath: currentPath ?? this.currentPath,
      currentPosition: currentPosition ?? this.currentPosition,
      destination: destination ?? this.destination,
      isNavigating: isNavigating ?? this.isNavigating,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  /// Get next waypoint based on current position
  Coordinate? get nextWaypoint {
    if (currentPath == null || currentPosition == null) return null;
    return currentPath!.getNextWaypoint(currentPosition!.coordinate, 30.0);
  }

  /// Calculate heading to next waypoint
  double? get headingToNextWaypoint {
    if (currentPosition == null || nextWaypoint == null) return null;
    return currentPosition!.headingTo(nextWaypoint!);
  }

  /// Check if arrived at destination
  bool get hasArrived {
    if (currentPath == null || currentPosition == null) return false;
    final distance = currentPosition!.coordinate.distanceTo(currentPath!.destination);
    return distance < 30.0; // Within 30 pixels
  }
}

/// Navigation state notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  final CalculateNavigationPath calculatePath;

  NavigationNotifier(this.calculatePath) : super(const NavigationState());

  /// Start navigation to a product
  Future<void> navigateToProduct(Product product, Coordinate startPosition) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      destination: product,
    );

    // Calculate path
    final result = await calculatePath(NavigationParams(
      start: startPosition,
      destination: product.location,
    ));

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (path) {
        state = state.copyWith(
          currentPath: path,
          isNavigating: true,
          isLoading: false,
          error: null,
          currentPosition: UserPosition(
            coordinate: startPosition,
            heading: 0.0,
            accuracy: 5.0,
            source: PositionSource.simulated,
            timestamp: DateTime.now(),
          ),
        );
      },
    );
  }

  /// Update current position during navigation
  void updatePosition(UserPosition position) {
    if (!state.isNavigating) return;

    state = state.copyWith(currentPosition: position);

    // Check if arrived
    if (state.hasArrived) {
      stopNavigation();
    }
  }

  /// Stop navigation
  void stopNavigation() {
    state = const NavigationState();
  }

  /// Simulate position update (for demo/testing)
  void simulateMovement(Coordinate newPosition) {
    if (!state.isNavigating || state.currentPosition == null) return;

    final newUserPosition = state.currentPosition!.copyWith(
      coordinate: newPosition,
      timestamp: DateTime.now(),
    );

    updatePosition(newUserPosition);
  }
}

/// Navigation provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  final repository = ref.watch(pathfindingRepositoryProvider);
  final calculatePath = CalculateNavigationPath(repository);
  return NavigationNotifier(calculatePath);
});

/// Current map scale provider (for zoom)
final mapScaleProvider = StateProvider<double>((ref) => 1.0);

/// Map offset provider (for pan)
final mapOffsetProvider = StateProvider<Offset>((ref) => Offset.zero);
