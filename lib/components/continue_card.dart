import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class ContinueCard extends StatelessWidget {
  final Widget child;
  const ContinueCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: BoxDecoration(
          color: kAbuHitam,
          border: Border.all(color: kAbu),
          borderRadius: BorderRadius.circular(12)),
      child: child,
    );
  }
}
