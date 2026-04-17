import 'package:flutter/material.dart';

class MobileWrapper extends StatelessWidget {
  final Widget child;
  const MobileWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 440, // Very close to real phone width
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(40), // Rounded corners like phone
          border: Border.all(color: Colors.black, width: 12),
        ),
        child: ClipRRect(borderRadius: BorderRadius.circular(28), child: child),
      ),
    );
  }
}
