import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/soal_page.dart';
import 'package:flutter/material.dart';

class Leveling extends StatelessWidget {
  const Leveling({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit 1',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'Energi potensial & energi kinetik',
                      style: kRegularTextStyle.copyWith(
                          fontSize: 13, color: kGreySecondary),
                    )
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                    color: kAbu, borderRadius: BorderRadius.circular(100)),
                child: Row(
                  children: [
                    Image.asset(
                      'images/diamond.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '22',
                      style: kBoldTextStyle.copyWith(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
        Expanded(
          child: SizedBox(
            width: width * 0.65,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SoalPage(
                                    isPembahasan: false,
                                  )));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset('images/playTiles.png')),
                  ),
                  Image.asset('images/activePath.png'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('images/playTiles.png')),
                  Image.asset('images/activePath.png'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('images/quizTiles.png')),
                  Image.asset('images/disabledPath.png'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('images/lockedTiles.png')),
                  Image.asset('images/disabledPath.png'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('images/lockedTiles.png')),
                  Image.asset('images/disabledPath.png'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset('images/lockedTiles.png')),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
