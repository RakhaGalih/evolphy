import 'package:evolphy/components/profile_tile.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'images/bg.png',
          height: 200,
        ),
        Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              'images/profile.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Rakha',
              style: kMediumTextStyle.copyWith(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Profile',
                        style: kMediumTextStyle.copyWith(fontSize: 14),
                      ),
                      const Spacer(),
                      Text('Edit Profil',
                          style: kRegularTextStyle.copyWith(
                              fontSize: 14, color: kUnguText)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: kGrey),
                    child: const Column(
                      children: [
                        ProfileTile(title: 'Username', value: 'Rakha'),
                        ProfileTile(
                            title: 'No.telepon atau email',
                            value: '+6281222333444'),
                        ProfileTile(title: 'Password', value: '••••••••••'),
                        ProfileTile(
                            title: 'Alamat',
                            value: 'Jl.Sukabirus no.4, Kec.Bojongsoang'),
                      ],
                    ),
                  ),
                  Text(
                    'Lainnya',
                    style: kMediumTextStyle.copyWith(fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: kGrey),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const IconProfileTile(
                              title: 'Notifikasi',
                              color: kWhite,
                              icon: Icons.notifications_outlined,
                            ),
                            const Spacer(),
                            Switch(
                              // This bool value toggles the switch.
                              value: light,
                              activeColor: kUnguText,
                              onChanged: (bool value) {
                                // This is called when the user toggles the switch.
                                setState(() {
                                  light = value;
                                });
                              },
                            )
                          ],
                        ),
                        const IconProfileTile(
                          title: 'Help & Support',
                          color: kWhite,
                          icon: Icons.support_agent_outlined,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const IconProfileTile(
                          title: 'Logout',
                          color: kRed,
                          icon: Icons.logout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
