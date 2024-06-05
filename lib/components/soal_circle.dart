import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SoalCircle extends StatelessWidget {
  final int no;
  final bool isDone;
  const SoalCircle({super.key, required this.no, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 37,
      height: 37,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isDone) ? const Color(0xFFBF00FF) : const Color(0xFF4C4F5B)),
      child: Text(
        no.toString(),
        style: kMediumTextStyle.copyWith(fontSize: 16),
      ),
    );
  }
}

class SoalCircleFloat extends StatelessWidget {
  final int no;
  final bool isTrue;
  const SoalCircleFloat({super.key, required this.no, required this.isTrue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      height: 37,
      child: Stack(
        children: [
          Container(
            width: 37,
            height: 37,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xFF4C4F5B)),
            child: Text(
              no.toString(),
              style: kMediumTextStyle.copyWith(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                  color: (isTrue)
                      ? const Color(0xFF37CE5F)
                      : const Color(0xFFEC2E2E),
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
