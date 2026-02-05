import 'package:flutter/material.dart';
import '../../../domain/entities/product.dart';

/// Product marker widget shown on the map
/// Optimized for performance with gestures
class ProductMarker extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final bool isSelected;

  const ProductMarker({
    super.key,
    required this.product,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? 32 : 24,
        height: isSelected ? 32 : 24,
        decoration: BoxDecoration(
          color: _getCategoryColor(product.category),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            _getCategoryIcon(product.category),
            color: Colors.white,
            size: isSelected ? 18 : 14,
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    // Map categories to colors for visual distinction
    switch (category.toLowerCase()) {
      case 'electronics':
        return Colors.blue;
      case 'clothing':
        return Colors.purple;
      case 'food':
        return Colors.orange;
      case 'home':
        return Colors.green;
      case 'sports':
        return Colors.red;
      case 'books':
        return Colors.brown;
      case 'toys':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.computer;
      case 'clothing':
        return Icons.checkroom;
      case 'food':
        return Icons.restaurant;
      case 'home':
        return Icons.home;
      case 'sports':
        return Icons.sports_basketball;
      case 'books':
        return Icons.book;
      case 'toys':
        return Icons.toys;
      default:
        return Icons.shopping_bag;
    }
  }
}
