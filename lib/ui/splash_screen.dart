import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget buildLogo() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
      child: RotatedBox(
        quarterTurns: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: RichText(
              text: TextSpan(
                  text: 'NOTES',
                  style: TextStyle(
                      color: Colors.white, fontSize: 10, letterSpacing: 15.0),
                  children: [
                    TextSpan(
                        text: '\nGoldFish',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 3,
                          fontSize: 20,
                          height: 1,
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42C694),
              Color(0xFF119A52),
              Color(0xFF0B6243),
              Color(0xFF021817),
            ],
            transform: GradientRotation(pi / 2),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: buildLogo(),
            )
          ],
        ));
  }
}
