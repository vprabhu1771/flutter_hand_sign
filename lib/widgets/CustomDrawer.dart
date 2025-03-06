import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/screens/HandSignDictionaryScreen.dart';
import 'package:flutter_hand_sign/screens/LiveCamera.dart';

import '../screens/LanguageToHandSignScreen.dart';
import '../screens/SettingScreen.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            _createDrawerItem(icon: Icons.settings, text: 'Settings', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(title: 'Settings'),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.handshake, text: 'Hand Sign Dictionary', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HandSignDictionaryScreen(title: "Hand Sign Dictionary"),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.handshake, text: 'Live Translation', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LiveCamera(title: "Live Translation"),
                ),
              );

            }),

            _createDrawerItem(icon: Icons.handshake, text: 'Language to Hand Sign', onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageToHandSignScreen(title: "Language to Hand Sign"),
                ),
              );

            }),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}