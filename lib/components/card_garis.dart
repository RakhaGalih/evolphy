import 'package:flutter/material.dart';

import '../constants/constant.dart';

class CardGaris extends StatelessWidget {
  final Widget child;
  const CardGaris({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: kAbuHitam,
            border: Border.all(color: kAbu),
            borderRadius: BorderRadius.circular(12)),
        child: child);
  }
}
