import 'package:flutter/material.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_item_card.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:provider/provider.dart';

class PantryItemsScreen extends StatelessWidget {
  const PantryItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryItemsProvider = context.watch<PantryItemsProvider>();
    final items = pantryItemsProvider.totalItems;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search items...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    pantryItemsProvider.setSearchTerm(value);
                  },
                ),
              ),
              const SizedBox(width: 12),
              // Sort Button
              IconButton(
                onPressed: () {
                  pantryItemsProvider.toggleSortDirection();
                },
                icon: Icon(
                  pantryItemsProvider.isSortAscending
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: Theme.of(context).colorScheme.primary,
                ),
                tooltip: pantryItemsProvider.isSortAscending
                    ? 'Sort by expiration (oldest first)'
                    : 'Sort by expiration (newest first)',
              ),
            ],
          ),
        ),

        Expanded(
          child: pantryItemsProvider.totalItems.isEmpty
              ? _NoItemsPlaceHolder()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return PantryItemCard(item: item);
                  },
                ),
        ),
      ],
    );
  }
}

class _NoItemsPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pantryItemsProvider = context.watch<PantryItemsProvider>();
    final hasItems = pantryItemsProvider.hasItems;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            hasItems ? 'Search result is empty' : 'Your pantry is empty',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 20),
          ),
          SizedBox(height: 4),
          Text(
            hasItems
                ? 'Try changing the searching terms'
                : 'Add your first item',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
