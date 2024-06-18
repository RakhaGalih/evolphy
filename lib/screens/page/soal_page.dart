// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/screens/page/nilai_page.dart';
import 'package:flutter/material.dart';

class SoalPage extends StatelessWidget {
  final bool isPembahasan;
  const SoalPage({
    super.key,
    required this.isPembahasan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const BackAppBar(
          title: 'Unit 3',
        ),
        GestureDetector(
          onTap: () {
            if (!isPembahasan) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NilaiPage()));
            }
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color(0xFF252836),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                for (int i = 0; i < 10; i++)
                  isPembahasan
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SoalCircleFloat(
                            no: i + 1,
                            isTrue: kebenaranSoal[i],
                          ),
                        )
                      : SoalCircle(
                          no: i + 1,
                          isDone: i % 2 == 0,
                        )
              ]),
            ),
          ),
        )
      ],
    ));
  }
}
