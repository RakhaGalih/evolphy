// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:evolphy/constants/constant.dart';

class Soal extends StatelessWidget {
  final String soal;
  final String pertanyaan;
  final TextEditingController controller;
  const Soal({
    Key? key,
    required this.soal,
    required this.pertanyaan,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            soal,
            textAlign: TextAlign.justify,
            style: kSemiBoldTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Pertanyaan :',
            style: kSemiBoldTextStyle.copyWith(fontSize: 16, color: kUnguText),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            pertanyaan,
            textAlign: TextAlign.justify,
            style: kSemiBoldTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                'Jawabanmu',
                style:
                    kSemiBoldTextStyle.copyWith(fontSize: 16, color: kAbuText),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12),
                        filled: true,
                        fillColor: kAbuHitam,
                        hintStyle: const TextStyle(color: kAbu),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 1,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
