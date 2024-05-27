import 'package:evolphy/components/navbar_icon.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/models/data_model.dart';
import 'package:evolphy/models/navcard_model.dart';
import 'package:evolphy/screens/homepage.dart';
import 'package:evolphy/screens/leveling.dart';
import 'package:evolphy/screens/profile.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
    ];
    return Consumer<DataModel>(builder: (context, data, child) {
      List<Widget> widgetOptions = <Widget>[
        const HomePage(),
        const ProfilePage(),
        const Leveling()
      ];
      return Scaffold(
        body: widgetOptions[data.selectedNavBar],
        bottomNavigationBar: Material(
          color: kGreyText.withOpacity(0.2),
          child: InkWell(
            onTap: () {},
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        navIcons.length,
                        (index) => NavBarIcon(
                              isActive: data.selectedNavBar == index,
                              index: index,
                              color: navIcons[index].color,
                              icon: navIcons[index].icon,
                              activeIcon: navIcons[index].activeIcon!,
                            ))),
              ),
            ),
          ),
        ),
      );
    });
  }
}
