import 'package:pantry_pal/features/pantry/data/pantry_item.dart';
import 'package:uuid/uuid.dart';

class PantryItemsModel {
  late final uuid = Uuid();

  String editingItemId = "";
  String searchTerm = "";
  bool isSortAscending = false;

  List<PantryItem> items = [];
  List<String> categories = [
    'Fruits',
    'Drinks',
    'Bakery',
    'Pasta',
    'Oils & Sauces',
    'Paper & Plastic',
  ];

  bool addItem(
    String name,
    String category,
    int quantity,
    DateTime expirationDate,
  ) {
    if (categories.contains(category)) {
      var newItem = PantryItem(
        id: uuid.v1(),
        name: name,
        category: category,
        quantity: quantity,
        expirationDate: expirationDate,
      );
      items.add(newItem);
      return true;
    }
    return false;
  }

  bool editItem(
    String itemId,
    String name,
    String category,
    int quantity,
    DateTime expirationDate,
  ) {
    if (categories.contains(category)) {
      items.removeWhere((item) => item.id == itemId);
      var newItem = PantryItem(
        id: itemId,
        name: name,
        category: category,
        quantity: quantity,
        expirationDate: expirationDate,
      );
      items.add(newItem);
      return true;
    }
    return false;
  }

  void removeItem(String itemId) {
    items.removeWhere((item) => item.id == itemId);
  }

  void addFromJson(Map<String, dynamic> json) {
    var newItem = PantryItem.fromJson(json);
    if (categories.contains(newItem.category)) {
      items.add(newItem);
    }
  }
}
