import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/coordinate.dart';
import '../../../domain/entities/product.dart';
import '../../providers/database_provider.dart';
import '../../widgets/map/interactive_store_map.dart';

/// Admin screen for managing products and paths
/// Protected by password
class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  Coordinate? _selectedCoordinate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Exit Admin Mode',
          ),
        ],
        bottom: TabBar(
          onTap: (index) => setState(() => _selectedTab = index),
          tabs: const [
            Tab(icon: Icon(Icons.inventory_2), text: 'Products'),
            Tab(icon: Icon(Icons.route), text: 'Paths'),
            Tab(icon: Icon(Icons.map), text: 'Map'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          _buildProductsTab(),
          _buildPathsTab(),
          _buildMapTab(),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: _showAddProductDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add Product'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
          ),
        ),
        Expanded(
          child: _buildProductList(),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return Consumer(
      builder: (context, ref, child) {
        // This would connect to productListProvider
        return const Center(
          child: Text('Product list will appear here'),
        );
      },
    );
  }

  Widget _buildPathsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton.icon(
                onPressed: _generatePathGrid,
                icon: const Icon(Icons.grid_4x4),
                label: const Text('Generate Path Grid'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Click on map to toggle node walkability',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Expanded(
          child: InteractiveStoreMap(
            mapImagePath: 'assets/maps/store_map.png',
            mapWidth: 2000,
            mapHeight: 1500,
            showAllProducts: false,
            onMapTap: _onPathNodeTap,
          ),
        ),
      ],
    );
  }

  Widget _buildMapTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Upload Store Map',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select an image of your store layout',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _uploadMap,
              icon: const Icon(Icons.image),
              label: const Text('Choose Image'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialog() {
    final nameController = TextEditingController();
    final barcodeController = TextEditingController();
    final categoryController = TextEditingController();
    final descriptionController = TextEditingController();
    final aisleController = TextEditingController();
    final shelfController = TextEditingController();
    final quantityController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: barcodeController,
                decoration: const InputDecoration(labelText: 'Barcode'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextField(
                controller: aisleController,
                decoration: const InputDecoration(labelText: 'Aisle Number'),
              ),
              TextField(
                controller: shelfController,
                decoration: const InputDecoration(labelText: 'Shelf Number'),
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              if (_selectedCoordinate != null)
                Text(
                  'Location: (${_selectedCoordinate!.x.toInt()}, ${_selectedCoordinate!.y.toInt()})',
                  style: const TextStyle(color: Colors.green),
                )
              else
                const Text(
                  'Tap on map to set location',
                  style: TextStyle(color: Colors.orange),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedCoordinate != null) {
                _addProduct(
                  name: nameController.text,
                  barcode: barcodeController.text,
                  category: categoryController.text,
                  description: descriptionController.text,
                  aisle: aisleController.text,
                  shelf: shelfController.text,
                  quantity: int.tryParse(quantityController.text) ?? 0,
                  location: _selectedCoordinate!,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addProduct({
    required String name,
    required String barcode,
    required String category,
    required String description,
    required String aisle,
    required String shelf,
    required int quantity,
    required Coordinate location,
  }) async {
    final repository = ref.read(productRepositoryProvider);
    final uuid = ref.read(uuidProvider);

    final product = Product(
      id: uuid.v4(),
      name: name,
      barcode: barcode,
      category: category,
      description: description,
      quantity: quantity,
      aisleNumber: aisle,
      shelfNumber: shelf,
      location: location,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final result = await repository.addProduct(product);

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${failure.message}')),
        );
      },
      (product) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
      },
    );
  }

  void _generatePathGrid() async {
    final repository = ref.read(pathfindingRepositoryProvider);

    final result = await repository.generatePathGrid(
      mapWidth: 2000,
      mapHeight: 1500,
      spacing: 50,
    );

    result.fold(
      (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${failure.message}')),
        );
      },
      (nodes) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Generated ${nodes.length} path nodes')),
        );
      },
    );
  }

  void _onPathNodeTap(Coordinate coordinate) {
    // Toggle walkability of node at this coordinate
    setState(() {
      _selectedCoordinate = coordinate;
    });
  }

  void _uploadMap() {
    // Image picker logic would go here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Map upload feature coming soon')),
    );
  }
}
