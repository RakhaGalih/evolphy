// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/components/card_garis.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/materi_detail_screen.dart';
import 'package:flutter/material.dart';

class MateriIcon extends StatelessWidget {
  final Color color;
  final String image;
  const MateriIcon({
    super.key,
    required this.color,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Image.asset(image),
    );
  }
}

class MateriCard extends StatelessWidget {
  final Color color;
  final String image;
  final String title;
  const MateriCard({
    super.key,
    required this.color,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DetailMateriPage();
          }));
        },
        child: CardGaris(
            child: Row(
          children: [
            MateriIcon(color: color, image: 'images/$image'),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: kSemiBoldTextStyle.copyWith(fontSize: 16),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: kWhite,
            )
          ],
        )),
      ),
    );
  }
}
