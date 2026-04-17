import 'package:flutter/material.dart';

class FormName extends StatelessWidget {
  final TextEditingController nameController;
  const FormName({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        labelText: 'Item Name',
        hintText: 'e.g. Milk, Apples, Rice',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter item name';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}
