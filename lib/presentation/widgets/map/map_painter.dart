import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../domain/entities/coordinate.dart';
import '../../../domain/entities/path_node.dart';

/// Custom painter for drawing navigation paths on the map
class NavigationPathPainter extends CustomPainter {
  final NavigationPath path;
  final Coordinate? currentPosition;

  NavigationPathPainter({
    required this.path,
    this.currentPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw the path line
    _drawPath(canvas);

    // Draw waypoint dots
    _drawWaypoints(canvas);

    // Draw animated arrow at current position (if navigating)
    if (currentPosition != null) {
      _drawDirectionArrow(canvas);
    }
  }

  void _drawPath(Canvas canvas) {
    if (path.waypoints.length < 2) return;

    final paint = Paint()
      ..color = Colors.blue.withOpacity(0.6)
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Create path
    final pathToDraw = Path();
    pathToDraw.moveTo(path.waypoints.first.x, path.waypoints.first.y);

    for (int i = 1; i < path.waypoints.length; i++) {
      pathToDraw.lineTo(path.waypoints[i].x, path.waypoints[i].y);
    }

    canvas.drawPath(pathToDraw, paint);

    // Draw dashed outline for better visibility
    final outlinePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas.drawPath(pathToDraw, outlinePaint);
    canvas.drawPath(pathToDraw, paint);
  }

  void _drawWaypoints(Canvas canvas) {
    final waypointPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Start marker (green)
    canvas.drawCircle(
      Offset(path.start.x, path.start.y),
      8,
      Paint()..color = Colors.green,
    );

    // End marker (red)
    canvas.drawCircle(
      Offset(path.destination.x, path.destination.y),
      8,
      Paint()..color = Colors.red,
    );

    // Intermediate waypoints (blue dots)
    for (int i = 1; i < path.waypoints.length - 1; i++) {
      final waypoint = path.waypoints[i];
      canvas.drawCircle(
        Offset(waypoint.x, waypoint.y),
        4,
        waypointPaint,
      );
    }
  }

  void _drawDirectionArrow(Canvas canvas) {
    if (currentPosition == null || path.waypoints.isEmpty) return;

    // Find next waypoint
    Coordinate? nextWaypoint;
    for (final waypoint in path.waypoints) {
      if (currentPosition!.distanceTo(waypoint) > 30.0) {
        nextWaypoint = waypoint;
        break;
      }
    }

    if (nextWaypoint == null) {
      nextWaypoint = path.waypoints.last;
    }

    // Calculate direction
    final dx = nextWaypoint.x - currentPosition!.x;
    final dy = nextWaypoint.y - currentPosition!.y;
    final angle = math.atan2(dy, dx);

    // Draw arrow
    canvas.save();
    canvas.translate(currentPosition!.x, currentPosition!.y);
    canvas.rotate(angle);

    final arrowPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final arrowPath = Path()
      ..moveTo(20, 0)
      ..lineTo(-10, -10)
      ..lineTo(-5, 0)
      ..lineTo(-10, 10)
      ..close();

    // Draw shadow
    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = Colors.black.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    canvas.drawPath(arrowPath, arrowPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(NavigationPathPainter oldDelegate) {
    return oldDelegate.currentPosition != currentPosition ||
        oldDelegate.path != path;
  }
}
