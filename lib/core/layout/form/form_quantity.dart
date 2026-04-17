import 'package:flutter/material.dart';

class FormQuantity extends StatelessWidget {
  final int quantity;
  final Function setQuantity;
  const FormQuantity({
    super.key,
    required this.quantity,
    required this.setQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Quantity:', style: TextStyle(fontSize: 16)),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => setQuantity(quantity - 1),
          icon: const Icon(Icons.remove),
        ),
        const SizedBox(width: 4),
        Text('$quantity', style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () => setQuantity(quantity + 1),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
