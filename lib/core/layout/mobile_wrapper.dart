import 'package:flutter/material.dart';

class MobileWrapper extends StatelessWidget {
  final Widget child;
  const MobileWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(minWidth: 240, maxWidth: 440),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }
}
