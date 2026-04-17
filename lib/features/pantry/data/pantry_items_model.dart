import 'package:pantry_pal/features/pantry/data/pantry_category.dart';
import 'package:pantry_pal/features/pantry/data/pantry_item.dart';
import 'package:uuid/uuid.dart';

class PantryItemsModel {
  late final uuid = Uuid();

  String editingItemId = "";
  String searchTerm = "";
  bool isSortAscending = false;

  List<PantryItem> items = [];
  List<PantryCategory> categories = [];

  PantryItemsModel() {
    categories.add(
      PantryCategory(
        name: 'Baking',
        step: 100,
        singular: 'gramm',
        multiple: 'gramms',
      ),
    );
    categories.add(
      PantryCategory(
        name: 'Breakfast',
        step: 100,
        singular: 'ml',
        multiple: 'mls',
      ),
    );
    categories.add(
      PantryCategory(
        name: 'Grains',
        step: 100,
        singular: 'gramm',
        multiple: 'gramms',
      ),
    );
    categories.add(PantryCategory(name: 'Canned Goods'));
    categories.add(
      PantryCategory(
        name: 'Oil & vinegar',
        step: 100,
        singular: 'ml',
        multiple: 'mls',
      ),
    );
    categories.add(
      PantryCategory(
        name: 'Drinks',
        step: 100,
        singular: 'ml',
        multiple: 'mls',
      ),
    );
    categories.add(
      PantryCategory(
        name: 'Spices',
        step: 10,
        singular: 'gramm',
        multiple: 'gramms',
      ),
    );
    categories.add(
      PantryCategory(
        name: 'Toppings',
        step: 10,
        singular: 'gramm',
        multiple: 'gramms',
      ),
    );
    categories.add(PantryCategory(name: 'Snacks'));
    categories.add(
      PantryCategory(
        name: 'Supplements',
        step: 100,
        singular: 'gramm',
        multiple: 'gramms',
      ),
    );
    categories.add(PantryCategory(name: 'Fruits'));
  }

  bool hasCategory(String categoryName) {
    return categories.any((category) => category.name == categoryName);
  }

  bool addItem(
    String name,
    String category,
    int quantity,
    DateTime expirationDate,
  ) {
    if (hasCategory(category)) {
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
    if (hasCategory(category)) {
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
    if (hasCategory(newItem.category)) {
      items.add(newItem);
    }
  }
}
