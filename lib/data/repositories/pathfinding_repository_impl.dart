import 'dart:collection';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/coordinate.dart';
import '../../domain/entities/path_node.dart' as domain;
import '../../domain/repositories/pathfinding_repository.dart';
import '../datasources/local/database.dart';
import '../models/path_node_model.dart';
import 'package:drift/drift.dart' as drift;

/// Implementation of PathfindingRepository with A* algorithm
class PathfindingRepositoryImpl implements PathfindingRepository {
  final AppDatabase database;
  final Uuid uuid;

  PathfindingRepositoryImpl(this.database, this.uuid);

  @override
  Future<Either<Failure, List<domain.PathNode>>> getAllPathNodes() async {
    try {
      final nodes = await database.getAllPathNodes();
      return Right(nodes.map((n) => n.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch path nodes: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.PathNode>> getPathNodeById(String id) async {
    try {
      final node = await database.getPathNodeById(id);
      if (node == null) {
        return const Left(InvalidPathNodeFailure('Path node not found'));
      }
      return Right(node.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch path node: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.PathNode>> getClosestWalkableNode(Coordinate coordinate) async {
    try {
      final nodes = await database.getWalkablePathNodes();
      if (nodes.isEmpty) {
        return const Left(InvalidPathNodeFailure('No walkable nodes found'));
      }

      // Find closest node using Euclidean distance
      PathNode? closestNode;
      double minDistance = double.infinity;

      for (final node in nodes) {
        final nodeCoord = Coordinate(x: node.positionX, y: node.positionY);
        final distance = coordinate.distanceTo(nodeCoord);
        if (distance < minDistance) {
          minDistance = distance;
          closestNode = node;
        }
      }

      if (closestNode == null) {
        return const Left(InvalidPathNodeFailure('No closest node found'));
      }

      return Right(closestNode.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to find closest node: $e'));
    }
  }

  @override
  Future<Either<Failure, NavigationPath>> calculatePath({
    required Coordinate start,
    required Coordinate destination,
  }) async {
    try {
      // Get all walkable nodes
      final nodesResult = await getAllPathNodes();
      if (nodesResult.isLeft()) {
        return Left((nodesResult as Left).value);
      }

      final allNodes = (nodesResult as Right<Failure, List<PathNode>>).value;
      final walkableNodes = allNodes.where((n) => n.isWalkable).toList();

      if (walkableNodes.isEmpty) {
        return const Left(PathNotFoundFailure('No walkable path nodes available'));
      }

      // Find start and end nodes
      final startNodeResult = await getClosestWalkableNode(start);
      final endNodeResult = await getClosestWalkableNode(destination);

      if (startNodeResult.isLeft() || endNodeResult.isLeft()) {
        return const Left(PathNotFoundFailure('Could not find start or end nodes'));
      }

      final startNode = (startNodeResult as Right<Failure, PathNode>).value;
      final endNode = (endNodeResult as Right<Failure, PathNode>).value;

      // Run A* algorithm
      final waypoints = _aStarPathfinding(
        startNode: startNode,
        endNode: endNode,
        allNodes: allNodes,
      );

      if (waypoints.isEmpty) {
        return const Left(PathNotFoundFailure('No path found between start and destination'));
      }

      // Calculate total distance
      double totalDistance = 0.0;
      for (int i = 0; i < waypoints.length - 1; i++) {
        totalDistance += waypoints[i].distanceTo(waypoints[i + 1]);
      }

      // Estimate duration (assume walking speed of 1.4 m/s, ~5 km/h)
      // Adjust pixel-to-meter ratio as needed
      const pixelsPerMeter = 10.0; // Example: 10 pixels = 1 meter
      final distanceInMeters = totalDistance / pixelsPerMeter;
      final secondsNeeded = (distanceInMeters / 1.4).ceil();

      return Right(NavigationPath(
        waypoints: waypoints,
        totalDistance: totalDistance,
        estimatedDuration: Duration(seconds: secondsNeeded),
      ));
    } catch (e) {
      return Left(DatabaseFailure('Failed to calculate path: $e'));
    }
  }

  /// A* Pathfinding Algorithm Implementation
  /// Returns list of coordinates representing the path
  List<Coordinate> _aStarPathfinding({
    required PathNode startNode,
    required PathNode endNode,
    required List<PathNode> allNodes,
  }) {
    // Create node map for quick lookup
    final nodeMap = <String, PathNode>{};
    for (final node in allNodes) {
      nodeMap[node.id] = node;
    }

    // A* data structures
    final openSet = PriorityQueue<_AStarNode>((a, b) => a.fScore.compareTo(b.fScore));
    final closedSet = <String>{};
    final gScores = <String, double>{};
    final parents = <String, PathNode>{};

    // Initialize
    gScores[startNode.id] = 0.0;
    final startHeuristic = startNode.position.distanceTo(endNode.position);
    openSet.add(_AStarNode(
      node: startNode,
      gScore: 0.0,
      fScore: startHeuristic * AppConstants.aStarHeuristicWeight,
    ));

    int iterations = 0;

    while (openSet.isNotEmpty && iterations < AppConstants.maxPathfindingIterations) {
      iterations++;

      // Get node with lowest fScore
      final current = openSet.removeFirst();

      // Check if we reached the destination
      if (current.node.id == endNode.id) {
        return _reconstructPath(parents, endNode);
      }

      closedSet.add(current.node.id);

      // Explore neighbors
      for (final neighborId in current.node.connectedNodeIds) {
        if (closedSet.contains(neighborId)) continue;

        final neighbor = nodeMap[neighborId];
        if (neighbor == null || !neighbor.isWalkable) continue;

        // Calculate tentative gScore
        final tentativeGScore = gScores[current.node.id]! +
            current.node.position.distanceTo(neighbor.position);

        if (!gScores.containsKey(neighborId) || tentativeGScore < gScores[neighborId]!) {
          // This path is better
          parents[neighborId] = current.node;
          gScores[neighborId] = tentativeGScore;

          final heuristic = neighbor.position.distanceTo(endNode.position);
          final fScore = tentativeGScore + (heuristic * AppConstants.aStarHeuristicWeight);

          // Add to open set if not already there
          if (!openSet.any((n) => n.node.id == neighborId)) {
            openSet.add(_AStarNode(
              node: neighbor,
              gScore: tentativeGScore,
              fScore: fScore,
            ));
          }
        }
      }
    }

    // No path found
    return [];
  }

  /// Reconstruct path from parents map
  List<Coordinate> _reconstructPath(Map<String, PathNode> parents, PathNode endNode) {
    final path = <Coordinate>[endNode.position];
    PathNode? current = endNode;

    while (current != null && parents.containsKey(current.id)) {
      current = parents[current.id];
      if (current != null) {
        path.insert(0, current.position);
      }
    }

    return path;
  }

  @override
  Future<Either<Failure, domain.PathNode>> addPathNode(PathNode node) async {
    try {
      await database.insertPathNode(node.toCompanion());
      return Right(node);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add path node: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.PathNode>> updatePathNode(PathNode node) async {
    try {
      // Get the database node first
      final dbNode = await database.getPathNodeById(node.id);
      if (dbNode == null) {
        return const Left(InvalidPathNodeFailure('Path node not found'));
      }

      // Create updated database node
      final updatedDbNode = dbNode.copyWith(
        positionX: node.position.x,
        positionY: node.position.y,
        isWalkable: node.isWalkable,
        connectedNodeIds: jsonEncode(node.connectedNodeIds),
      );

      await database.updatePathNode(updatedDbNode);
      return Right(updatedDbNode.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to update path node: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePathNode(String id) async {
    try {
      await database.deletePathNode(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete path node: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> connectNodes(String nodeId1, String nodeId2) async {
    try {
      final node1 = await database.getPathNodeById(nodeId1);
      final node2 = await database.getPathNodeById(nodeId2);

      if (node1 == null || node2 == null) {
        return const Left(InvalidPathNodeFailure('One or both nodes not found'));
      }

      // Parse connections
      final connections1 = node1.connectedNodeIds.isEmpty
          ? <String>[]
          : List<String>.from(jsonDecode(node1.connectedNodeIds));

      final connections2 = node2.connectedNodeIds.isEmpty
          ? <String>[]
          : List<String>.from(jsonDecode(node2.connectedNodeIds));

      // Add bidirectional connection
      if (!connections1.contains(nodeId2)) connections1.add(nodeId2);
      if (!connections2.contains(nodeId1)) connections2.add(nodeId1);

      // Update both nodes
      await database.updatePathNode(
        node1.copyWith(connectedNodeIds: jsonEncode(connections1)),
      );
      await database.updatePathNode(
        node2.copyWith(connectedNodeIds: jsonEncode(connections2)),
      );

      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to connect nodes: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> disconnectNodes(String nodeId1, String nodeId2) async {
    try {
      final node1 = await database.getPathNodeById(nodeId1);
      final node2 = await database.getPathNodeById(nodeId2);

      if (node1 == null || node2 == null) {
        return const Left(InvalidPathNodeFailure('One or both nodes not found'));
      }

      // Parse and update connections
      final connections1 = List<String>.from(jsonDecode(node1.connectedNodeIds))
        ..remove(nodeId2);
      final connections2 = List<String>.from(jsonDecode(node2.connectedNodeIds))
        ..remove(nodeId1);

      await database.updatePathNode(
        node1.copyWith(connectedNodeIds: jsonEncode(connections1)),
      );
      await database.updatePathNode(
        node2.copyWith(connectedNodeIds: jsonEncode(connections2)),
      );

      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to disconnect nodes: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.PathNode>>> generatePathGrid({
    required double mapWidth,
    required double mapHeight,
    required double spacing,
  }) async {
    try {
      final nodes = <PathNode>[];
      final nodeIdMap = <String, String>{}; // Maps "x,y" to node ID

      // Generate grid nodes
      for (double x = spacing / 2; x < mapWidth; x += spacing) {
        for (double y = spacing / 2; y < mapHeight; y += spacing) {
          final id = uuid.v4();
          final position = Coordinate(x: x, y: y);

          nodeIdMap['$x,$y'] = id;

          // Initially all nodes are walkable (admin will mark obstacles later)
          nodes.add(PathNode(
            id: id,
            position: position,
            isWalkable: true,
            connectedNodeIds: [],
          ));
        }
      }

      // Connect adjacent nodes (4-way connectivity)
      for (final node in nodes) {
        final x = node.position.x;
        final y = node.position.y;
        final connections = <String>[];

        // Check right neighbor
        final rightKey = '${x + spacing},$y';
        if (nodeIdMap.containsKey(rightKey)) {
          connections.add(nodeIdMap[rightKey]!);
        }

        // Check down neighbor
        final downKey = '$x,${y + spacing}';
        if (nodeIdMap.containsKey(downKey)) {
          connections.add(nodeIdMap[downKey]!);
        }

        // Check left neighbor
        final leftKey = '${x - spacing},$y';
        if (nodeIdMap.containsKey(leftKey)) {
          connections.add(nodeIdMap[leftKey]!);
        }

        // Check up neighbor
        final upKey = '$x,${y - spacing}';
        if (nodeIdMap.containsKey(upKey)) {
          connections.add(nodeIdMap[upKey]!);
        }

        // Update node with connections
        final index = nodes.indexOf(node);
        nodes[index] = node.copyWith(connectedNodeIds: connections);
      }

      // Batch insert into database
      final companions = nodes.map((n) => n.toCompanion()).toList();
      await database.insertPathNodesBatch(companions);

      return Right(nodes);
    } catch (e) {
      return Left(DatabaseFailure('Failed to generate path grid: $e'));
    }
  }

  @override
  Future<Either<Failure, domain.PathNode>> toggleNodeWalkability(String nodeId) async {
    try {
      final node = await database.getPathNodeById(nodeId);
      if (node == null) {
        return const Left(InvalidPathNodeFailure('Path node not found'));
      }

      final updatedNode = node.copyWith(isWalkable: !node.isWalkable);
      await database.updatePathNode(updatedNode);

      return Right(updatedNode.toDomain());
    } catch (e) {
      return Left(DatabaseFailure('Failed to toggle node walkability: $e'));
    }
  }

  @override
  Future<Either<Failure, List<domain.PathNode>>> getPathNodesInArea({
    required double minX,
    required double maxX,
    required double minY,
    required double maxY,
  }) async {
    try {
      final nodes = await database.getPathNodesInArea(
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
      );
      return Right(nodes.map((n) => n.toDomain()).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to fetch path nodes in area: $e'));
    }
  }
}

/// Internal class for A* algorithm priority queue
class _AStarNode {
  final PathNode node;
  final double gScore;
  final double fScore;

  _AStarNode({
    required this.node,
    required this.gScore,
    required this.fScore,
  });
}

/// Priority queue implementation for A*
class PriorityQueue<T> {
  final List<T> _items = [];
  final Comparator<T> _comparator;

  PriorityQueue(this._comparator);

  void add(T item) {
    _items.add(item);
    _items.sort(_comparator);
  }

  T removeFirst() {
    return _items.removeAt(0);
  }

  bool get isNotEmpty => _items.isNotEmpty;

  bool any(bool Function(T) test) {
    return _items.any(test);
  }
}
