import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import '../../domain/entities/path_node.dart' as domain;
import '../../domain/entities/coordinate.dart';
import '../datasources/local/database.dart';

/// Data model for PathNode - converts between database and domain
/// Extension on database PathNode
extension PathNodeModel on PathNode {
  /// Convert database row to domain entity
  domain.PathNode toDomain() {
    // Parse JSON array of connected node IDs
    final List<String> connections = connectedNodeIds.isEmpty
        ? []
        : List<String>.from(jsonDecode(connectedNodeIds));

    return domain.PathNode(
      id: id,
      position: Coordinate(x: positionX, y: positionY),
      isWalkable: isWalkable,
      connectedNodeIds: connections,
    );
  }
}

/// Extension on domain PathNode to convert to database format
extension PathNodeToDrift on domain.PathNode {
  /// Convert domain entity to Drift companion (for insert/update)
  PathNodesCompanion toCompanion() {
    return PathNodesCompanion(
      id: drift.Value(id),
      positionX: drift.Value(position.x),
      positionY: drift.Value(position.y),
      isWalkable: drift.Value(isWalkable),
      connectedNodeIds: drift.Value(jsonEncode(connectedNodeIds)),
    );
  }
}
