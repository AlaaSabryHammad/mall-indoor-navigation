import 'package:equatable/equatable.dart';

/// Represents the store's floor plan map
class StoreMap extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double width;
  final double height;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StoreMap({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Get aspect ratio for proper display
  double get aspectRatio => width / height;

  /// Check if coordinates are within map bounds
  bool containsPoint(double x, double y) {
    return x >= 0 && x <= width && y >= 0 && y <= height;
  }

  StoreMap copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? width,
    double? height,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StoreMap(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      width: width ?? this.width,
      height: height ?? this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, width, height, createdAt, updatedAt];

  @override
  String toString() => 'StoreMap(id: $id, name: $name, size: ${width}x$height)';
}
