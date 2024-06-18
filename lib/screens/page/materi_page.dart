import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset('images/purple-bg.png'),
        SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.only(top: 150),
            decoration: const BoxDecoration(
                color: kBG,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const BackAppBar(),
          Text(
            'Listrik dan Magnet',
            style: kSemiBoldTextStyle.copyWith(fontSize: 24),
          ),
          Text(
            'Listrik magnet  adalah cabang fisika  yang membahas interaksi antara medan listrik dan medan magnet.',
            style: kSemiBoldTextStyle.copyWith(fontSize: 16),
          )
        ])
      ]),
    );
  }
}