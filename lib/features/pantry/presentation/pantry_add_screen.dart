import 'package:flutter/material.dart';
import 'package:pantry_pal/core/layout/form/form_category_selector.dart';
import 'package:pantry_pal/core/layout/form/form_expiration_date.dart';
import 'package:pantry_pal/core/layout/form/form_name.dart';
import 'package:pantry_pal/core/layout/form/form_quantity.dart';
import 'package:pantry_pal/core/layout/form/form_action_button.dart';
import 'package:pantry_pal/core/layout/column_padding.dart';
import 'package:pantry_pal/core/layout/form/form_padding.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:provider/provider.dart';

class PantryAddScreen extends StatelessWidget {
  const PantryAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FormPadding(child: const AddItemForm()),
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  String _selectedCategory = 'Fruits';
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 30));
  int _quantity = 1;

  void _saveItem(PantryItemsProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.addItem(
        _nameController.text.trim(),
        _selectedCategory,
        _quantity,
        _expirationDate,
      );

      // Show success message and go back
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item added!')));

      Navigator.pop(context); // Return to previous screen
    }
  }

  bool _checkForm() {
    return _nameController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() => {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pantryItemsProvider = context.watch<PantryItemsProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormName(nameController: _nameController),
          ColumnPadding(),
          FormCategorySelector(
            categories: pantryItemsProvider.categories,
            currentCategory: _selectedCategory,
            setCategory: (String category) => setState(() {
              _selectedCategory = category;
            }),
          ),
          ColumnPadding(),
          FormExpirationDate(
            currentDate: _expirationDate,
            setExpirationDate: (DateTime selectedDate) => setState(() {
              _expirationDate = selectedDate;
            }),
          ),
          ColumnPadding(),
          FormQuantity(
            quantity: _quantity,
            setQuantity: (int quantity) => setState(() {
              _quantity = quantity;
            }),
          ),
          ColumnPadding(),
          FormActionButton(
            title: "Add item",
            onPress: () => _saveItem(pantryItemsProvider),
            disabled: !_checkForm(),
          ),
        ],
      ),
    );
  }
}
