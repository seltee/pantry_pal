import 'package:flutter/material.dart';

class FormActionButton extends StatelessWidget {
  final VoidCallback onPress;
  final bool disabled;
  final String title;

  const FormActionButton({
    super.key,
    required this.onPress,
    required this.title,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: disabled ? null : onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
