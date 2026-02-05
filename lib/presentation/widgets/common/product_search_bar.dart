import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../../../domain/entities/product.dart';
import '../../providers/product_provider.dart';
import '../../providers/navigation_provider.dart';

/// Search bar with autocomplete for products
/// Debounced for performance
class ProductSearchBar extends ConsumerStatefulWidget {
  final Function(Product)? onProductSelected;

  const ProductSearchBar({
    super.key,
    this.onProductSelected,
  });

  @override
  ConsumerState<ProductSearchBar> createState() => _ProductSearchBarState();
}

class _ProductSearchBarState extends ConsumerState<ProductSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Debounce search input
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).state = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchedProductsProvider);

    return Column(
      children: [
        // Search input
        Container(
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
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search for products...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),

        // Autocomplete results
        if (_controller.text.isNotEmpty)
          searchResults.when(
            data: (products) {
              if (products.isEmpty) {
                return _buildNoResults();
              }

              return _buildResultsList(products);
            },
            loading: () => _buildLoadingIndicator(),
            error: (error, stack) => _buildError(error.toString()),
          ),
      ],
    );
  }

  Widget _buildResultsList(List<Product> products) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
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
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: products.length > 10 ? 10 : products.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: const Icon(Icons.inventory_2, color: Colors.blue),
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              '${product.category} • ${product.locationDisplay}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            trailing: product.isInStock
                ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                : const Icon(Icons.cancel, color: Colors.red, size: 20),
            onTap: () {
              _focusNode.unfocus();
              _controller.clear();
              ref.read(searchQueryProvider.notifier).state = '';

              if (widget.onProductSelected != null) {
                widget.onProductSelected!(product);
              }

              // Set as selected product
              ref.read(selectedProductProvider.notifier).state = product;
            },
          );
        },
      ),
    );
  }

  Widget _buildNoResults() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'No products found',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(String error) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
