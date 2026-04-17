import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pantry_pal/features/pantry/data/pantry_category.dart';
import 'package:pantry_pal/features/pantry/data/pantry_item.dart';
import 'package:pantry_pal/features/pantry/data/pantry_items_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantryItemsProvider extends ChangeNotifier {
  final PantryItemsModel _model = PantryItemsModel();
  final SharedPreferences _prefs;

  PantryItemsProvider(this._prefs) {
    _loadItems();
    _loadPreferences();
    setTestItems();
  }

  void setTestItems() async {
    await Future.delayed(const Duration(milliseconds: 100));
    var now = DateTime.now();
    _model.addItem('Apples', 'Fruits', 5, now.add(Duration(days: 1)));
    _model.addItem('Oranges', 'Fruits', 5, now.add(Duration(days: 3)));
    _model.addItem('Milk', 'Drinks', 2000, now.add(Duration(days: 4)));
    _model.addItem('Apple Juice', 'Drinks', 500, now.add(Duration(days: 5)));
    _model.addItem('Cookies', 'Snacks', 10, now.add(Duration(days: 6)));
    _model.addItem('Candies', 'Snacks', 20, now.add(Duration(days: 10)));
    _model.addItem('Waffles', 'Snacks', 4, now.add(Duration(days: 2)));
    _model.addItem('Bread', 'Snacks', 1, now.add(Duration(days: 2)));
    _model.addItem('Pasta', 'Grains', 1, now.add(Duration(days: 2)));
    _model.addItem(
      'Oils & Sauces',
      'Oils & Sauces',
      1,
      now.add(Duration(days: 3)),
    );
    _model.addItem(
      'Paper & Plastic',
      'Paper & Plastic',
      1,
      now.subtract(Duration(days: 4)),
    );

    notifyListeners();
  }

  PantryItemsModel get model => _model;
  List<PantryCategory> get categories => model.categories;
  bool get hasItems => model.items.isNotEmpty;
  bool get isSortAscending => model.isSortAscending;

  PantryCategory getCategory(String name) {
    try {
      return model.categories.where((category) => category.name == name).first;
    } catch (e) {
      return PantryCategory(name: "Unknown");
    }
  }

  List<PantryItem> get totalItems {
    if (_model.isSortAscending) {
      model.items.sort(
        (a, b) => a.expirationDate.difference(b.expirationDate).inDays,
      );
    } else {
      model.items.sort(
        (a, b) => b.expirationDate.difference(a.expirationDate).inDays,
      );
    }
    if (model.searchTerm.isNotEmpty) {
      var lowerCaseSearch = model.searchTerm.toLowerCase();
      return model.items
          .where((item) => item.name.toLowerCase().contains(lowerCaseSearch))
          .toList();
    }
    return model.items;
  }

  List<PantryItem> get expiringItems {
    return model.items.where((item) {
      var difference = item.expirationDate.difference(DateTime.now()).inHours;
      return difference >= 0 && difference < 48;
    }).toList();
  }

  List<PantryItem> get expiredItems {
    return model.items.where((item) {
      var difference = item.expirationDate.difference(DateTime.now()).inHours;
      return difference < 0;
    }).toList();
  }

  bool get hasEditingItem {
    return model.editingItemId.isNotEmpty;
  }

  PantryItem get editingItem {
    return model.items.firstWhere((item) => model.editingItemId == item.id);
  }

  void addItem(
    String name,
    String category,
    int quantity,
    DateTime expirationDate,
  ) {
    _model.addItem(name, category, quantity, expirationDate);
    _saveItems();
    notifyListeners();
  }

  void setSearchTerm(String term) {
    _model.searchTerm = term;
    notifyListeners();
  }

  void editItem(
    String name,
    String category,
    int quantity,
    DateTime expirationDate,
  ) {
    _model.editItem(
      model.editingItemId,
      name,
      category,
      quantity,
      expirationDate,
    );
    _saveItems();
    _loadPreferences();
    notifyListeners();
  }

  void removeEditedItem() {
    _model.removeItem(model.editingItemId);
    model.editingItemId = '';
    notifyListeners();
  }

  void setEditingItem(String itemId) {
    _model.editingItemId = itemId;
    notifyListeners();
  }

  void toggleSortDirection() async {
    _model.isSortAscending = !_model.isSortAscending;
    await _prefs.setBool('sort_ascending', model.isSortAscending);
    notifyListeners();
  }

  Future<void> _loadItems() async {
    final String? jsonString = _prefs.getString('pantry_items');
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        for (var itemJson in jsonList) {
          model.addFromJson(itemJson);
        }
      } catch (e) {
        print('Error loading pantry items');
      }
    }

    notifyListeners();
  }

  Future<void> _saveItems() async {
    final jsonList = model.items.map((item) => item.toJson()).toList();
    await _prefs.setString('pantry_items', jsonEncode(jsonList));
  }

  Future<void> _loadPreferences() async {
    model.isSortAscending = _prefs.getBool('sort_ascending') ?? false;
  }
}
