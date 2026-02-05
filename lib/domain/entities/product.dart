import 'package:equatable/equatable.dart';
import 'coordinate.dart';

/// Core Product entity - represents an item in the store
/// Business logic is placed here, not in models
class Product extends Equatable {
  final String id;
  final String name;
  final String barcode;
  final String category;
  final String description;
  final String? imageUrl;
  final int quantity;
  final String aisleNumber;
  final String shelfNumber;
  final Coordinate location;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.id,
    required this.name,
    required this.barcode,
    required this.category,
    required this.description,
    this.imageUrl,
    required this.quantity,
    required this.aisleNumber,
    required this.shelfNumber,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Business logic: Check if product is in stock
  bool get isInStock => quantity > 0;

  /// Business logic: Check if product is low stock (less than 10)
  bool get isLowStock => quantity > 0 && quantity < 10;

  /// Business logic: Get display location string
  String get locationDisplay => 'Aisle $aisleNumber, Shelf $shelfNumber';

  /// Business logic: Get search keywords for fuzzy search
  List<String> get searchKeywords => [
        name.toLowerCase(),
        barcode,
        category.toLowerCase(),
        aisleNumber,
        shelfNumber,
      ];

  /// Create a copy with updated fields
  Product copyWith({
    String? id,
    String? name,
    String? barcode,
    String? category,
    String? description,
    String? imageUrl,
    int? quantity,
    String? aisleNumber,
    String? shelfNumber,
    Coordinate? location,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      aisleNumber: aisleNumber ?? this.aisleNumber,
      shelfNumber: shelfNumber ?? this.shelfNumber,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        barcode,
        category,
        description,
        imageUrl,
        quantity,
        aisleNumber,
        shelfNumber,
        location,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() => 'Product(id: $id, name: $name, barcode: $barcode, location: $location)';
}
