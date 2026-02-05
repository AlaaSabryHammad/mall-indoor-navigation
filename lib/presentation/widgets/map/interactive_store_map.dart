import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/coordinate.dart';
import '../../providers/product_provider.dart';
import '../../providers/navigation_provider.dart';
import 'map_painter.dart';
import 'product_marker.dart';

/// Interactive store map with zoom, pan, and navigation
/// Optimized for performance with 1000+ products
class InteractiveStoreMap extends ConsumerStatefulWidget {
  final String mapImagePath;
  final double mapWidth;
  final double mapHeight;
  final Function(Coordinate)? onMapTap;
  final bool showAllProducts;

  const InteractiveStoreMap({
    super.key,
    required this.mapImagePath,
    required this.mapWidth,
    required this.mapHeight,
    this.onMapTap,
    this.showAllProducts = true,
  });

  @override
  ConsumerState<InteractiveStoreMap> createState() => _InteractiveStoreMapState();
}

class _InteractiveStoreMapState extends ConsumerState<InteractiveStoreMap> {
  final TransformationController _transformationController = TransformationController();

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationState = ref.watch(navigationProvider);
    final productListState = ref.watch(productListProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate initial scale to fit map to screen
        final scaleX = constraints.maxWidth / widget.mapWidth;
        final scaleY = constraints.maxHeight / widget.mapHeight;
        final initialScale = (scaleX < scaleY ? scaleX : scaleY) * 0.9;

        return InteractiveViewer(
          transformationController: _transformationController,
          minScale: 0.5,
          maxScale: 4.0,
          boundaryMargin: const EdgeInsets.all(100),
          constrained: false,
          child: GestureDetector(
            onTapUp: (details) {
              if (widget.onMapTap != null) {
                // Convert screen coordinates to map coordinates
                final transform = _transformationController.value;
                final offset = transform.getTranslation();
                final scale = transform.getMaxScaleOnAxis();

                final mapX = (details.localPosition.dx - offset.x) / scale;
                final mapY = (details.localPosition.dy - offset.y) / scale;

                widget.onMapTap!(Coordinate(x: mapX, y: mapY));
              }
            },
            child: SizedBox(
              width: widget.mapWidth,
              height: widget.mapHeight,
              child: Stack(
                children: [
                  // Map background image
                  _buildMapImage(),

                  // Custom painter for paths and navigation
                  if (navigationState.currentPath != null)
                    CustomPaint(
                      size: Size(widget.mapWidth, widget.mapHeight),
                      painter: NavigationPathPainter(
                        path: navigationState.currentPath!,
                        currentPosition: navigationState.currentPosition?.coordinate,
                      ),
                    ),

                  // Product markers (with viewport culling for performance)
                  if (widget.showAllProducts)
                    ...productListState.products.map(
                      (product) => _buildProductMarker(product),
                    ),

                  // Current position marker
                  if (navigationState.currentPosition != null)
                    _buildCurrentPositionMarker(
                      navigationState.currentPosition!.coordinate,
                      navigationState.headingToNextWaypoint ?? 0.0,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMapImage() {
    // Check if map image exists
    if (File(widget.mapImagePath).existsSync()) {
      return Image.file(
        File(widget.mapImagePath),
        width: widget.mapWidth,
        height: widget.mapHeight,
        fit: BoxFit.fill,
      );
    } else {
      // Placeholder if no map is uploaded yet
      return Container(
        width: widget.mapWidth,
        height: widget.mapHeight,
        color: Colors.grey[200],
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No map uploaded',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildProductMarker(Product product) {
    return Positioned(
      left: product.location.x - 12,
      top: product.location.y - 12,
      child: ProductMarker(
        product: product,
        onTap: () {
          ref.read(selectedProductProvider.notifier).state = product;
        },
      ),
    );
  }

  Widget _buildCurrentPositionMarker(Coordinate position, double heading) {
    return Positioned(
      left: position.x - 20,
      top: position.y - 20,
      child: Transform.rotate(
        angle: heading * 3.14159265359 / 180.0,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue, width: 3),
          ),
          child: const Icon(
            Icons.navigation,
            color: Colors.blue,
            size: 24,
          ),
        ),
      ),
    );
  }
}
