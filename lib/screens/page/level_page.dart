import 'package:evolphy/components/back_appbar.dart';
import 'package:evolphy/components/materi_icon.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/screens/page/soal_ar_page.dart';
import 'package:evolphy/screens/page/try_out_page.dart';
import 'package:evolphy/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  late bool isLocked = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    load();
  }

  Future<void> load() async {
    isLocked = await loadIsLockedFromPrefs();
    setState(() {});
  }

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
                    "Level 1",
                    style: kSemiBoldTextStyle.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Level 1 adalah tahap dasar yang menguji pemahaman fundamental tentang konsep-konsep fisika sederhana yang biasa diimplementasikan pada kompetisi Olimpiadi Sains tingkat Kabupaten.",
                    style: kSemiBoldTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                      color: kAbu, borderRadius: BorderRadius.circular(100)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                        '22',
                        style: kBoldTextStyle.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Ayo semangat mengerjakan soalnya!',
                  style: kBoldTextStyle.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 8,
                ),
                MateriCard(
                    color: kBlue,
                    image: "solat.png",
                    title: "Latihan Soal AR",
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const SoalARPage(isPembahasan: false);
                      }));
                    }),
                MateriCard(
                  color: kPink,
                  image: "tryout.png",
                  title: "Try Out",
                  isLocked: isLocked,
                  onTap: () {
                    if (!isLocked) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TryOutPage();
                      }));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
