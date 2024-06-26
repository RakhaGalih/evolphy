import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/level_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                      'Latihan soal berbasis AR',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'Visualisasi solusi AR & tryout per levelnya',
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
                      '0',
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
              padding: const EdgeInsets.only(bottom: 24),
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
                              builder: (context) => const LevelPage()));
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('images/playTiles.svg')),
                  ),
                  SvgPicture.asset('images/disabledPath.svg'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('images/lockedTiles.svg')),
                  SvgPicture.asset('images/disabledPath.svg'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset('images/lockedTiles.svg')),
                  SvgPicture.asset('images/disabledPath.svg'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('images/lockedTiles.svg')),
                  SvgPicture.asset('images/disabledPath.svg'),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset('images/lockedTiles.svg')),
                  SvgPicture.asset('images/disabledPath.svg'),
                  Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset('images/lockedTiles.svg')),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
