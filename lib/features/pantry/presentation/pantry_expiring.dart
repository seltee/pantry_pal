import 'package:flutter/material.dart';
import 'package:pantry_pal/features/pantry/data/pantry_item.dart';

class PantryExpiring extends StatelessWidget {
  final PantryItem item;
  const PantryExpiring({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final daysLeft = item.expirationDate.difference(DateTime.now()).inDays + 1;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            '${item.name} expiring in $daysLeft ${daysLeft == 1 ? 'day' : 'days'}',
          ),
        ),
      ),
    );
  }
}
