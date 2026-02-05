import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/coordinate.dart';
import '../../../domain/entities/product.dart';
import '../../providers/product_provider.dart';
import '../../providers/navigation_provider.dart';
import '../../widgets/map/interactive_store_map.dart';
import '../../widgets/common/product_search_bar.dart';

/// Main home screen with search and map
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Simulated user position (replace with real positioning later)
  final Coordinate _currentPosition = const Coordinate(x: 100, y: 100);

  @override
  Widget build(BuildContext context) {
    final selectedProduct = ref.watch(selectedProductProvider);
    final navigationState = ref.watch(navigationProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Stack(
          children: [
            // Map
            _buildMap(),

            // Top search bar
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: ProductSearchBar(
                onProductSelected: _onProductSelected,
              ),
            ),

            // Bottom sheet for selected product
            if (selectedProduct != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _buildProductBottomSheet(selectedProduct),
              ),

            // Navigation controls
            if (navigationState.isNavigating)
              Positioned(
                bottom: selectedProduct != null ? 200 : 16,
                left: 16,
                right: 16,
                child: _buildNavigationControls(navigationState),
              ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildMap() {
    return InteractiveStoreMap(
      mapImagePath: 'assets/maps/store_map.png', // Replace with actual path
      mapWidth: 2000,
      mapHeight: 1500,
      showAllProducts: true,
    );
  }

  Widget _buildProductBottomSheet(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Product name
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Category and location
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.category,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                product.locationDisplay,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Stock status
          Row(
            children: [
              Icon(
                product.isInStock ? Icons.check_circle : Icons.cancel,
                color: product.isInStock ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                product.isInStock
                    ? 'In Stock (${product.quantity})'
                    : 'Out of Stock',
                style: TextStyle(
                  color: product.isInStock ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Navigate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _onProductSelected(product),
              icon: const Icon(Icons.navigation),
              label: const Text('Navigate to this product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationControls(NavigationState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Icon(Icons.navigation, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Navigating to',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      state.destination?.name ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                state.currentPath?.estimatedDuration.inMinutes.toString() ?? '0',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const Text(' min'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                ref.read(navigationProvider.notifier).stopNavigation();
                ref.read(selectedProductProvider.notifier).state = null;
              },
              icon: const Icon(Icons.close),
              label: const Text('Stop Navigation'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Admin button
        FloatingActionButton(
          heroTag: 'admin',
          onPressed: () {
            // Navigate to admin screen
            Navigator.pushNamed(context, '/admin');
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.admin_panel_settings),
        ),
        const SizedBox(height: 12),
        // Recenter button
        FloatingActionButton(
          heroTag: 'recenter',
          onPressed: () {
            // Reset map position
          },
          child: const Icon(Icons.my_location),
        ),
      ],
    );
  }

  void _onProductSelected(Product product) {
    // Start navigation
    ref.read(navigationProvider.notifier).navigateToProduct(
          product,
          _currentPosition,
        );

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navigating to ${product.name}'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Stop',
          onPressed: () {
            ref.read(navigationProvider.notifier).stopNavigation();
          },
        ),
      ),
    );
  }
}
