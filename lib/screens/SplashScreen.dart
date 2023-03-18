
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_app/screens/LoginScreen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'assets/images/bike.json',
                width: 400,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Image.asset('assets/images/logoblack.png'),
            ),
          ],
        ),
      );
  }
}
