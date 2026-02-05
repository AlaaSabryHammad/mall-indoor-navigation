import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/coordinate.dart';
import '../entities/path_node.dart';
import '../repositories/pathfinding_repository.dart';

/// Use case for calculating navigation path using A* algorithm
/// This is the core business logic for indoor navigation
class CalculateNavigationPath implements UseCase<NavigationPath, NavigationParams> {
  final PathfindingRepository repository;

  CalculateNavigationPath(this.repository);

  @override
  Future<Either<Failure, NavigationPath>> call(NavigationParams params) async {
    // Validate coordinates
    if (!_isValidCoordinate(params.start) || !_isValidCoordinate(params.destination)) {
      return const Left(InvalidCoordinatesFailure('Invalid start or destination coordinates'));
    }

    // Check if start and destination are too close
    if (params.start.distanceTo(params.destination) < 10.0) {
      // User is already at destination
      return Right(NavigationPath(
        waypoints: [params.start, params.destination],
        totalDistance: params.start.distanceTo(params.destination),
        estimatedDuration: const Duration(seconds: 0),
      ));
    }

    // Delegate pathfinding to repository
    return await repository.calculatePath(
      start: params.start,
      destination: params.destination,
    );
  }

  bool _isValidCoordinate(Coordinate coord) {
    return coord.x >= 0 && coord.y >= 0 && coord.x.isFinite && coord.y.isFinite;
  }
}

class NavigationParams {
  final Coordinate start;
  final Coordinate destination;

  const NavigationParams({
    required this.start,
    required this.destination,
  });
}
