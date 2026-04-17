class PantryItem {
  final String id;
  final String name;
  final String category;
  final DateTime expirationDate;
  final int quantity;

  int get daysLeft => expirationDate.difference(DateTime.now()).inDays;

  PantryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.expirationDate,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'expirationDate': expirationDate.toIso8601String(),
    };
  }

  factory PantryItem.fromJson(Map<String, dynamic> json) {
    return PantryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      quantity: json['quantity'] as int,
      expirationDate: DateTime.parse(json['expirationDate'] as String),
    );
  }
}
