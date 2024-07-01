import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/data_model.dart';
import 'package:evolphy/models/navcard_model.dart';
import 'package:evolphy/screens/home/forum.dart';
import 'package:evolphy/screens/home/homepage.dart';
import 'package:evolphy/screens/home/leveling.dart';
import 'package:evolphy/screens/home/modul.dart';
import 'package:evolphy/screens/home/profile.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<NavIcon> navIcons = [
      const NavIcon(
          icon: FluentIcons.apps_20_regular,
          activeIcon: FluentIcons.apps_20_filled,
          color: kUngu),
      const NavIcon(
          icon: FluentIcons.apps_list_20_regular,
          activeIcon: FluentIcons.apps_list_20_filled,
          color: kUngu),
      const NavIcon(
          icon: FluentIcons.heart_20_regular,
          activeIcon: FluentIcons.heart_20_filled,
          color: kUngu),
      const NavIcon(
          icon: FluentIcons.channel_20_regular,
          activeIcon: FluentIcons.channel_20_filled,
          color: kUngu),
    ];
    return Consumer<DataModel>(builder: (context, data, child) {
      List<Widget> widgetOptions = <Widget>[
        const BerandaPage(),
        const ModulPage(),
        const Leveling(),
        const ForumPage(),
        const ProfilePage(),
      ];
      return Scaffold(
        body: widgetOptions[data.selectedNavBar],
        bottomNavigationBar: Container(
          color: const Color(0xFF252836),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Container(
            color: const Color(0xFF252836),
            child: SafeArea(
              child: GNav(
                style: GnavStyle.google,
                selectedIndex: data.selectedNavBar,
                onTabChange: (index) {
                  Provider.of<DataModel>(context, listen: false)
                      .onNavBarTapped(index);
                },
                color: const Color(0xFF676D75),
                activeColor: Colors.white,
                tabBackgroundColor: const Color(0xFF9900CC),
                gap: 4,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                iconSize: 24,
                tabs: const [
                  GButton(
                    icon: Icons.home_outlined,
                    text: "Beranda",
                    iconSize: 26,
                  ),
                  GButton(icon: Icons.book, text: "Modul"),
                  GButton(icon: Icons.timeline, text: "Latihan"),
                  GButton(icon: Icons.chat_outlined, text: "Forum"),
                  GButton(icon: Icons.person, text: "Profil"),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
