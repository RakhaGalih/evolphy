// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/materi_icon.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/services/converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NilaiPage extends StatelessWidget {
  final int jumlahBenar;
  final int jumlahSoal;
  const NilaiPage({
    super.key,
    required this.jumlahBenar,
    required this.jumlahSoal,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
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
                                  '$jumlahBenar /',
                                  style:
                                      kMediumTextStyle.copyWith(fontSize: 24),
                                ),
                                Text(
                                  ' $jumlahSoal soal',
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
                              '${jumlahBenar * 100 ~/ jumlahSoal}',
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
                      for (int i = 0; i < listKlasifikasi.length; i++)
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listKlasifikasi[i].title,
                                        style: kSemiBoldTextStyle.copyWith(
                                            fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          for (int j = 0;
                                              j <
                                                  listKlasifikasi[i]
                                                      .noSoal
                                                      .length;
                                              j++)
                                            GestureDetector(
                                                onTap: () {
                                                  /*Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SoalPage(
                                                                isPembahasan: true,
                                                              )));*/
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: SoalCircleFloat(
                                                    no: listKlasifikasi[i]
                                                        .noSoal[j],
                                                    isTrue: areValuesEqual(
                                                        listSoalTryOut[
                                                                listKlasifikasi[i]
                                                                            .noSoal[
                                                                        j] -
                                                                    1]
                                                            .controller
                                                            .text,
                                                        listSoalTryOut[i]
                                                            .jawaban),
                                                  ),
                                                ))
                                        ],
                                      )
                                    ],
                                  ),
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
      ),
    );
  }
}
