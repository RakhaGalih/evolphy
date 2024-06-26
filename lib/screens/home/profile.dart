import 'package:evolphy/components/profile_tile.dart';
import 'package:evolphy/constants/constant.dart';
import 'package:evolphy/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool light = true;
  String? _username;
  String? _email;
  String? _telepon;
  String? _image;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getDataUser();
  }

  void resetData() {
    _username = null;
    _email = null;
    _telepon = null;
    _image = null;
  }

  Future<void> getDataUser() async {
    User? user = await AuthService().getCurrentUser();
    if (user != null) {
      String? fetchedUsername =
          await getProperty('users', user.uid, 'username');
      String? fetchedEmail = await getProperty('users', user.uid, 'email');
      String? fetchedImage = await getProperty('users', user.uid, 'image');
      String? fetchedTelepon = await getProperty('users', user.uid, 'telepon');
      setState(() {
        _username = fetchedUsername;
        _email = fetchedEmail;
        _image = fetchedImage;
        _telepon = fetchedTelepon;
      });
    }
  }

  Future<void> _navigateAndDisplayResult(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/edit');

    // Check what was returned and act accordingly
    if (result != null) {
      resetData();
      await getDataUser();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'images/bg.svg',
          fit: BoxFit.fitWidth,
        ),
        Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: CircleAvatar(
                  radius: 60,
                  backgroundColor: kAbuHitam,
                  child: MyNetworkImage(
                    imageURL: _image ??
                        'https://firebasestorage.googleapis.com/v0/b/evolphy-cfb2e.appspot.com/o/Rectangle%206.png?alt=media&token=2b96ff1a-6c58-478d-8c4d-482cf3ba02ef',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _username ?? 'null',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
                      GestureDetector(
                        onTap: () async {
                          await _navigateAndDisplayResult(context);
                        },
                        child: Text('Edit Profil',
                            style: kRegularTextStyle.copyWith(
                                fontSize: 14, color: kUnguText)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: kGrey),
                    child: Column(
                      children: [
                        ProfileTile(title: 'Username', value: _username),
                        ProfileTile(title: 'Email', value: _email),
                        ProfileTile(title: 'No Telepon', value: _telepon),
                        const ProfileTile(
                            title: 'Password', value: '••••••••••'),
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
                        GestureDetector(
                          onTap: () {
                            logOut(context);
                          },
                          child: const IconProfileTile(
                            title: 'Logout',
                            color: kRed,
                            icon: Icons.logout,
                          ),
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
