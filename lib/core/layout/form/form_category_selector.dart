import 'package:flutter/material.dart';

class FormCategorySelector extends StatelessWidget {
  final List<String> categories;
  final Function setCategory;
  final String currentCategory;
  const FormCategorySelector({
    super.key,
    required this.categories,
    required this.currentCategory,
    required this.setCategory,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: currentCategory,
      decoration: const InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(),
      ),
      items: categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setCategory(value);
        }
      },
    );
  }
}
