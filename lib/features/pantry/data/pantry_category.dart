import 'package:flutter/material.dart';

class PantryCategory {
  final String name;
  final int step;
  final String singular;
  final String multiple;
  final IconData icon;

  PantryCategory({
    required this.name,
    required this.icon,
    this.step = 1,
    this.singular = 'pc',
    this.multiple = 'pcs',
  });
}
