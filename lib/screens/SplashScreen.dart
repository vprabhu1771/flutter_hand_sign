import 'package:flutter/material.dart';
import 'dart:async';

import 'HomeScreen.dart';
import 'HomeScreen2.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(title: "Hand Sign")),
      ); // Navigate to HomeScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/splash_logo.jpg', width: 150), // Your splash image
      ),
    );
  }
}