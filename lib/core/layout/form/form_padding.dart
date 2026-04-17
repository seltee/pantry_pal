import 'package:flutter/material.dart';

class FormPadding extends StatelessWidget {
  final Widget child;
  const FormPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16),
      child: child,
    );
  }
}
