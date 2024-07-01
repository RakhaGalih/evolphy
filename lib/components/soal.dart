// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class SoalComponent extends StatelessWidget {
  final TextSpan soal;
  final TextSpan pertanyaan;
  final TextSpan pembahasan;
  final TextEditingController controller;
  final bool isDone;

  const SoalComponent({
    super.key,
    required this.soal,
    required this.pertanyaan,
    required this.pembahasan,
    required this.controller,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.justify,
              //soal
              text: soal),
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
          RichText(
              textAlign: TextAlign.justify,
              //pertanyaan
              text: pertanyaan),
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
                      enabled: !isDone,
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
          const SizedBox(
            height: 20,
          ),
          if (isDone)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 2,
                  color: kAbu,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Pembahasan :',
                  style: kSemiBoldTextStyle.copyWith(
                      fontSize: 16, color: kUnguText),
                ),
                const SizedBox(
                  height: 12,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    //pembahasan
                    text: pembahasan)
              ],
            ),
        ],
      ),
    );
  }
}

class TryOutComponent extends StatelessWidget {
  final TextSpan soal;
  final TextEditingController controller;
  const TryOutComponent({
    super.key,
    required this.soal,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.justify,
              //soal
              text: soal),
          const SizedBox(
            height: 24,
          ),
          Text(
            'Jawaban:',
            style: kSemiBoldTextStyle.copyWith(fontSize: 16, color: kUnguText),
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class PertanyaanComponent extends StatelessWidget {
  const PertanyaanComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
