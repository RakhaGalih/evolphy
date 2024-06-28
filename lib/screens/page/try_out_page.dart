// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/soal.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/screens/page/nilai_page.dart';
import 'package:evolphy/services/converter.dart';
import 'package:flutter/material.dart';

class TryOutPage extends StatefulWidget {
  const TryOutPage({
    super.key,
  });

  @override
  State<TryOutPage> createState() => _TryOutPageState();
}

class _TryOutPageState extends State<TryOutPage> {
  int _selectedIndex = 0;
  List<bool> kebenaran = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  int jumlahKebenaran() {
    int jumlahBenar = 0;
    for (int i = 0; i < listSoalTryOut.length - 1; i++) {
      if (areValuesEqual(
          listSoalTryOut[i].controller.text, listSoalTryOut[i].jawaban)) {
        jumlahBenar += 1;
      }
    }
    return jumlahBenar;
  }

  bool cekUdahKeisi() {
    int benar = 0;
    for (int i = 0; i < listSoalTryOut.length - 1; i++) {
      if (listSoalTryOut[i].controller.text.isNotEmpty) {
        benar += 1;
      }
    }
    if (benar == 9) {
      return true;
    } else {
      return false;
    }
  }

  void ubahKebenaran() {
    for (int i = 0; i < listSoalTryOut.length - 1; i++) {
      if (areValuesEqual(
          listSoalTryOut[i].controller.text, listSoalTryOut[i].jawaban)) {
        kebenaran[i] = true;
      }
      print(kebenaran[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isLeft = _selectedIndex == 0;
    final bool isRight = _selectedIndex == listSoalTryOut.length - 1;
    return Scaffold(
        body: Column(
      children: [
        const BackAppBar(
          title: 'Try Out 1',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: const Color(0xFF252836),
                borderRadius: BorderRadius.circular(10)),
            child: Row(children: [
              for (int i = 0; i < listSoalTryOut.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = i;
                    });
                  },
                  child: SoalCircle(
                    no: i + 1,
                    isDone: listSoalTryOut[i].controller.text.isNotEmpty,
                  ),
                )
            ]),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: TryOutComponent(
                    soal: listSoalTryOut[_selectedIndex].soal,
                    controller: listSoalTryOut[_selectedIndex].controller))),
        if (true)
          GestureDetector(
            onTap: () {
              ubahKebenaran();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NilaiPage(
                            jumlahBenar: jumlahKebenaran(),
                            jumlahSoal: listSoalTryOut.length,
                          )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              alignment: Alignment.center,
              height: 36,
              decoration: BoxDecoration(
                  color: kUngu, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Submit',
                style: kBoldTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ),
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
                        print(listSoalTryOut[0].jawaban);
                        _selectedIndex--;
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
                      '${_selectedIndex + 1}',
                      style: kSemiBoldTextStyle.copyWith(
                          fontSize: 20, color: kWhite),
                    ),
                    Text(
                      '/${listSoalTryOut.length}',
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
                        _selectedIndex++;
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
