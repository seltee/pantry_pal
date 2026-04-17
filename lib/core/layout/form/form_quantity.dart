import 'dart:math';

import 'package:flutter/material.dart';

class FormQuantity extends StatelessWidget {
  final int quantity;
  final int step;
  final Function setQuantity;
  final String singular;
  final String multiple;

  const FormQuantity({
    super.key,
    required this.quantity,
    required this.step,
    required this.setQuantity,
    required this.singular,
    required this.multiple,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Quantity:', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => setQuantity(max(quantity - step, step)),
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 4),
        Text('$quantity', style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () => setQuantity(quantity + step),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(width: 4),
        Text(
          quantity == 1 ? singular : multiple,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
