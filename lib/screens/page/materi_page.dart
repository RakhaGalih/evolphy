import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/materi_icon.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class MateriPage extends StatelessWidget {
  const MateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUnguGelap,
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'images/purple-bg.png',
                ),
                fit: BoxFit.cover),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const BackAppBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kategori Kinematika',
                    style: kSemiBoldTextStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'kinematika adalah cabang dari mekanika klasik yang membahas gerak benda dan sistem benda tanpa mempersoalkan gaya penyebab gerakan.',
                    style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF).withOpacity(0.24),
                        borderRadius: BorderRadius.circular(25)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.book,
                          color: kWhite,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '3 Materi',
                          style: kBoldTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: const BoxDecoration(
                color: kBG,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Materi',
                  style: kBoldTextStyle.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 4,
                ),
                const MateriCard(
                    color: kUngu, image: 'listrik.png', title: 'Coba'),
                const MateriCard(
                    color: kUngu, image: 'listrik.png', title: 'Coba'),
                const MateriCard(
                    color: kUngu, image: 'listrik.png', title: 'Coba')
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
