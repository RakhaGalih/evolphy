// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/materi_icon.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/materi_model.dart';
import 'package:evolphy/screens/page/materi_detail_screen.dart';
import 'package:flutter/material.dart';

class MateriPage extends StatelessWidget {
  final ModelJudulMateri materi;
  const MateriPage({
    super.key,
    required this.materi,
  });

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
                    materi.title,
                    style: kSemiBoldTextStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    materi.desc,
                    style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Source : Materi78 & Jendela Sains",
                    style: kSemiBoldTextStyle.copyWith(fontSize: 12),
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
                          '${materi.listMateri.length} Materi',
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
                for (int i = 0; i < materi.listMateri.length; i++)
                  MateriCard(
                      color: materi.listMateri[i].color,
                      image: materi.listMateri[i].image,
                      title: materi.listMateri[i].title,
                      materi: materi.listMateri[i],
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailMateriPage(
                            materi: materi.listMateri[i],
                          );
                        }));
                      }),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
