import 'package:flutter/material.dart';
import 'package:pantry_pal/core/layout/form/form_category_selector.dart';
import 'package:pantry_pal/core/layout/form/form_expiration_date.dart';
import 'package:pantry_pal/core/layout/form/form_name.dart';
import 'package:pantry_pal/core/layout/form/form_quantity.dart';
import 'package:pantry_pal/core/layout/form/form_action_button.dart';
import 'package:pantry_pal/core/layout/column_padding.dart';
import 'package:pantry_pal/core/layout/form/form_padding.dart';
import 'package:pantry_pal/core/layout/mobile_wrapper.dart';
import 'package:pantry_pal/features/pantry/data/pantry_item.dart';
import 'package:pantry_pal/features/pantry/presentation/pantry_items_provider.dart';
import 'package:provider/provider.dart';

class PantryEditScreen extends StatelessWidget {
  const PantryEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pantryItemsProvider = context.watch<PantryItemsProvider>();

    return MobileWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Item'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 24),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  size: 24,
                  color: Colors.red,
                ),
                tooltip: 'Delete item',
                onPressed: () {
                  pantryItemsProvider.removeEditedItem();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item removed!')),
                  );
                  Navigator.pop(context); // Return to previous screen
                },
              ),
            ),
          ],
        ),
        body: FormPadding(
          child: pantryItemsProvider.hasEditingItem
              ? EditItemForm(pantryItem: pantryItemsProvider.editingItem)
              : Container(),
        ),
      ),
    );
  }
}

class EditItemForm extends StatefulWidget {
  final PantryItem pantryItem;
  const EditItemForm({super.key, required this.pantryItem});

  @override
  State<EditItemForm> createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  String _selectedCategory = 'Fruits';
  DateTime _expirationDate = DateTime.now().add(const Duration(days: 30));
  int _quantity = 1;

  void _saveItem(PantryItemsProvider provider) {
    if (_formKey.currentState!.validate()) {
      provider.editItem(
        _nameController.text.trim(),
        _selectedCategory,
        _quantity,
        _expirationDate,
      );

      // Show success message and go back
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Item changed!')));

      Navigator.pop(context); // Return to previous screen
    }
  }

  bool _checkForm() {
    return _nameController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pantryItem.name);
    _selectedCategory = widget.pantryItem.category;
    _expirationDate = widget.pantryItem.expirationDate;
    _quantity = widget.pantryItem.quantity;
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
            title: "Save Item",
            onPress: () => _saveItem(pantryItemsProvider),
            disabled: !_checkForm(),
          ),
        ],
      ),
    );
  }
}
