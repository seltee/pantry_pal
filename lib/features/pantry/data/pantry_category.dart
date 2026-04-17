class PantryCategory {
  final String name;
  final int step;
  final String singular;
  final String multiple;

  PantryCategory({
    required this.name,
    this.step = 1,
    this.singular = 'pc',
    this.multiple = 'pcs',
  });
}
