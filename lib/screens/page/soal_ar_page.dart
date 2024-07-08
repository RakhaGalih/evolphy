// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/soal_circle.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/soal_model.dart';
import 'package:evolphy/screens/page/nilai_page.dart';
import 'package:evolphy/services/converter.dart';
import 'package:evolphy/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class SoalARPage extends StatefulWidget {
  final bool isPembahasan;
  const SoalARPage({
    super.key,
    required this.isPembahasan,
  });

  @override
  State<SoalARPage> createState() => _SoalARPageState();
}

class _SoalARPageState extends State<SoalARPage> {
  List<bool> isDones = [false, false, false];
  bool isDone() {
    int keisi = 0;
    for (int i = 0; i < listPertanyaanARs.length; i++) {
      if (listPertanyaanARs[i].controller.text.isNotEmpty &&
          areValuesEqual(listPertanyaanARs[i].controller.text,
              listPertanyaanARs[i].jawaban)) {
        keisi += 1;
      }
    }
    if (keisi == 3) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const BackAppBar(
          title: 'Unit 1',
        ),
        GestureDetector(
          onTap: () {
            if (!widget.isPembahasan) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NilaiPage(
                            jumlahBenar: 1,
                            jumlahSoal: 1,
                          )));
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
                SoalCircle(
                  no: 1,
                  isDone: isDone(),
                )
              ]),
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/soal/no1.png'),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Seorang pemain basket berlari dengan laju 3 m/s. Di suatu titik, dia melemparkan bola secara horizontal dengan suatu laju v0 relatif terhadap dirinya. Dia ingin agar bola mengenai target di B yang jaraknya s = 6,5 m dari posisi dia melemparkan bola (titik A), tetapi dia ingin membuat bola memantul sekali lagi dari lantai (lihat gambar). Tumbukan antara  bola dengan lantai tidak lenting sempurna dengan koefisien restitusi 0,8. Anggap ketinggian bola dari tanah saat dilempar adalah h = 1,25 m dan anggap besar percepatan gravitasi bumi adalah 10 m/s2.',
                style: kSemiBoldTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 24,
              ),
              if (!widget.isPembahasan)
                Text(
                  'Pertanyaan :',
                  style: kSemiBoldTextStyle.copyWith(
                      fontSize: 16, color: kUnguText),
                ),
              if (!widget.isPembahasan)
                const SizedBox(
                  height: 12,
                ),
              if (!widget.isPembahasan)
                for (int i = 0; i < listPertanyaanARs.length; i++)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listPertanyaanARs[i].pertanyaan,
                        style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Text(
                            'Jawabanmu',
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, color: kAbuText),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                  enabled: !isDones[i],
                                  controller: listPertanyaanARs[i].controller,
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
                      Row(
                        children: [
                          Text(
                            'Jawaban :',
                            style: kSemiBoldTextStyle.copyWith(
                                fontSize: 16, color: kUnguText),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isDones[i] = !isDones[i];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kUngu),
                              child: Text((isDones[i]) ? 'Batal' : 'Kirim'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (isDones[i])
                        areValuesEqual(listPertanyaanARs[i].controller.text,
                                listPertanyaanARs[i].jawaban)
                            ? Text(
                                "Mantap, jawaban kamu sudah benar! :D",
                                style: kSemiBoldTextStyle.copyWith(
                                    fontSize: 16, color: kUnguText),
                              )
                            : Text(
                                "Jawaban kamu masih salah, nih :)",
                                style: kSemiBoldTextStyle.copyWith(
                                    fontSize: 16, color: kRed),
                              ),
                      if (isDones[i])
                        const SizedBox(
                          height: 20,
                        ),
                    ],
                  ),
              if (widget.isPembahasan)
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
                    Text(
                      'Jawaban yang benar adalah: \n\nDiketahui:',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'Vp1t= 3 m/s\t\t\t\t\th = 1,25 m',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    Text(
                      'g = 10 m/s2\t\t\t\t\te = 0,8',
                      style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset('images/soal/pembahasan1.png'),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset('images/soal/pembahasan2.png'),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset('images/soal/pembahasan3.png'),
                  ],
                ),
            ],
          ),
        ))),
        if (isDone() && !widget.isPembahasan)
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SoalARPage(isPembahasan: true)));
              saveisLockedToPrefs(false);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              alignment: Alignment.center,
              height: 36,
              decoration: BoxDecoration(
                  color: kUngu, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Lihat Pembahasan',
                style: kBoldTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ),
        const SizedBox(
          height: 16,
        ),
        SafeArea(
          top: false,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              alignment: Alignment.center,
              height: 36,
              decoration: BoxDecoration(
                  color: kUngu, borderRadius: BorderRadius.circular(5)),
              child: Text(
                'Lihat Simulasi AR',
                style: kBoldTextStyle.copyWith(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
