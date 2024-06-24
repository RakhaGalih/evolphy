// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/screens/page/nilai_page.dart';
import 'package:flutter/material.dart';

class SoalPage extends StatefulWidget {
  final bool isPembahasan;
  const SoalPage({
    super.key,
    required this.isPembahasan,
  });

  @override
  State<SoalPage> createState() => _SoalPageState();
}

class _SoalPageState extends State<SoalPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isLeft = selectedIndex == 0;
    final bool isRight = selectedIndex == listSoal.length - 1;
    return Scaffold(
        body: Column(
      children: [
        const BackAppBar(
          title: 'Unit 3',
        ),
        GestureDetector(
          onTap: () {
            if (!widget.isPembahasan) {
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
                for (int i = 0; i < listSoal.length; i++)
                  widget.isPembahasan
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: SoalCircleFloat(
                            no: i + 1,
                            isTrue: kebenaranSoal[i],
                          ),
                        )
                      : SoalCircle(
                          no: i + 1,
                          isDone: listSoal[i].controller.text.isNotEmpty,
                        )
              ]),
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: listSoal[selectedIndex])),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!isLeft) {
                      setState(() {
                        selectedIndex--;
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLeft ? kUngu.withOpacity(0.6) : kUngu,
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: kWhite,
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${selectedIndex + 1}',
                      style: kSemiBoldTextStyle.copyWith(
                          fontSize: 20, color: kWhite),
                    ),
                    Text(
                      '/${listSoal.length}',
                      style: kSemiBoldTextStyle.copyWith(
                        fontSize: 20,
                        color: kAbuText,
                      ),
                    )
                  ],
                )),
                GestureDetector(
                  onTap: () {
                    if (!isRight) {
                      setState(() {
                        selectedIndex++;
                      });
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isRight ? kUngu.withOpacity(0.6) : kUngu,
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      color: kWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
