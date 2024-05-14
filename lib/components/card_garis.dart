import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CardGaris extends StatelessWidget {
  final Widget child;
  const CardGaris({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: abuGaris),
            borderRadius: BorderRadius.circular(12)),
        child: child);
  }
}
