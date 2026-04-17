import 'package:flutter/material.dart';
import 'package:pantry_pal/features/pantry/data/pantry_item.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_edit_screen.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:provider/provider.dart';

class PantryItemCard extends StatelessWidget {
  final PantryItem item;
  const PantryItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final itemsProvider = context.watch<PantryItemsProvider>();

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: InkWell(
          // InkWell inside the Card
          onTap: () {
            itemsProvider.setEditingItem(item.id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PantryEditScreen()),
            );
          },
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 60, child: _Icon(category: item.category)),
                Column(
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.merge(TextStyle(fontSize: 16)),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          item.category,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.merge(TextStyle(fontSize: 12)),
                        ),
                        Text(
                          " • ",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.merge(TextStyle(fontSize: 12)),
                        ),
                        Text(
                          item.quantity.toString(),
                          style: Theme.of(context).textTheme.displaySmall
                              ?.merge(TextStyle(fontSize: 12)),
                        ),
                        Text(
                          " pcs",
                          style: Theme.of(context).textTheme.displaySmall
                              ?.merge(TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                  child: _ExpirationTag(dateTime: item.expirationDate),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Icon extends StatelessWidget {
  final String category;
  const _Icon({required this.category});

  IconData _getIcon() {
    if (category == 'Pasta') {
      return Icons.dinner_dining_outlined;
    }
    if (category == 'Bakery') {
      return Icons.bakery_dining_outlined;
    }
    if (category == 'Drinks') {
      return Icons.local_drink_outlined;
    }

    return Icons.inventory_2_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(_getIcon(), size: 24);
  }
}

class _ExpirationTag extends StatelessWidget {
  final DateTime dateTime;
  const _ExpirationTag({required this.dateTime});

  Color _getColor(int difference) {
    if (difference <= 0) return Colors.red;
    if (difference <= 1) return Colors.deepOrange;
    if (difference <= 3) return Colors.orange;
    return Colors.green;
  }

  String _getText(int difference) {
    if (difference > 0) {
      return '$difference ${difference == 1 ? ' day' : ' days'}';
    } else {
      return "Expired";
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var difference = dateTime.difference(DateTime.now()).inDays;

    return Text(
      _getText(difference),
      style: theme.textTheme.displaySmall?.merge(
        TextStyle(fontSize: 20, color: _getColor(difference)),
      ),
    );
  }
}
