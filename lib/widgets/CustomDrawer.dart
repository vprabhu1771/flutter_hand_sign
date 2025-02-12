import 'package:flutter/material.dart';
import 'package:flutter_hand_sign/screens/HandSignDictionaryScreen.dart';

import '../screens/SettingScreen.dart';

class CustomDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            //   child: Text(
            //     'Menu',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24,
            //     ),
            //   ),
            // ),
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