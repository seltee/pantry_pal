import 'package:flutter/material.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_expiring.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_stat_card.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryItemsProvider = context.watch<PantryItemsProvider>();
    var totalAmount = pantryItemsProvider.totalItems.length;
    var soonAmount = pantryItemsProvider.expiringItems.length;
    var expiredAmount = pantryItemsProvider.expiredItems.length;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PantryStatCard(
              title: "Total",
              value: totalAmount,
              icon: Icons.inventory,
              color: Theme.of(context).iconTheme.color,
            ),
            PantryStatCard(
              title: "Expiring",
              value: soonAmount,
              icon: Icons.timer,
              color: soonAmount > 0
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).iconTheme.color,
            ),
            PantryStatCard(
              title: "Expired",
              value: expiredAmount,
              icon: Icons.warning,
              color: expiredAmount > 0
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).iconTheme.color,
            ),
          ],
        ),
        ...pantryItemsProvider.expiringItems
            .take(3)
            .map((item) => PantryExpiring(item: item)),
      ],
    );
  }
}
