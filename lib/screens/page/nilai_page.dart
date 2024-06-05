import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/materi_icon.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/screens/page/soal_page.dart';
import 'package:flutter/material.dart';

class NilaiPage extends StatelessWidget {
  const NilaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackAppBar(title: 'Hasil Quiz'),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xFF323647),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jawaban Benar',
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, color: kAbuText),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '9 /',
                                style: kMediumTextStyle.copyWith(fontSize: 24),
                              ),
                              Text(
                                ' 10 soal',
                                style: kMediumTextStyle.copyWith(
                                    fontSize: 20, color: kAbuText),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                          color: const Color(0xFF8F00BF),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Nilai',
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, color: kAbuText),
                          ),
                          Text(
                            '90',
                            style: kMediumTextStyle.copyWith(fontSize: 32),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pembahasan Soal',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (int i = 0; i < listSoal.length; i++)
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const MateriIcon(
                                  color: Color(0xFF7BB2FB),
                                  image: 'images/listrik.png'),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kinematik',
                                    style: kSemiBoldTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      for (int j = 0;
                                          j < listSoal[i].length;
                                          j++)
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SoalPage(
                                                            isPembahasan: true,
                                                          )));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: listSoal[i][j],
                                            ))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: const Color(0xFF4C4F5B),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
