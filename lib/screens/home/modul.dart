// ignore_for_file: prefer_const_constructors

import "package:evolphy/constants/constant.dart";
import "package:evolphy/models/materi_model.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class ModulPage extends StatelessWidget {
  const ModulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c202a),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Modul Materi',
                style: kSemiBoldTextStyle.copyWith(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: materi.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 275,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: materi[index].color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/materi');
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 65,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white.withOpacity(0.32),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.diamond,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        materi[index].diamond.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  materi[index].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: constraints.maxWidth * 0.12,
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              right: -15,
                              bottom: constraints.maxWidth * 0.25,
                              child: SvgPicture.asset(
                                materi[index].image,
                                width: constraints.maxWidth,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
