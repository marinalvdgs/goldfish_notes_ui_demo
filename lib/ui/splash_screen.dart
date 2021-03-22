import 'dart:math';

import 'package:flutter/material.dart';

const String fish = 'assets/goldfish.png';
const Duration splashDuration = Duration(seconds: 3);

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController fishController;
  Animation<Offset> bigFishAnimation;
  Animation<Offset> littleFishAnimation;
  Animation<double> opacityAnimation;

  @override
  initState() {
    fishController = AnimationController(duration: splashDuration, vsync: this)
      ..repeat();
    bigFishAnimation =
        Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 1.0)).animate(
            CurvedAnimation(parent: fishController, curve: Curves.slowMiddle));
    littleFishAnimation = Tween<Offset>(
            begin: Offset(-0.25, -1.0), end: Offset(-0.25, 1.0))
        .animate(CurvedAnimation(parent: fishController, curve: Curves.easeIn));
    opacityAnimation = Tween<double>(begin: 0.8, end: 0.0).animate(
        CurvedAnimation(parent: fishController, curve: Curves.easeOut));
    super.initState();
  }

  @override
  dispose() {
    fishController.dispose();
    super.dispose();
  }

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

  Widget buildBigFish() {
    return FittedBox(
      fit: BoxFit.none,
      child: Transform.rotate(
        angle: pi / 8,
        child: Image.asset(
          fish,
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
    );
  }

  Widget buildLittleFish() {
    return FadeTransition(
      opacity: opacityAnimation,
      child: FittedBox(
        fit: BoxFit.none,
        child: Transform.rotate(
          angle: pi / 8,
          child: Image.asset(
            fish,
            height: MediaQuery.of(context).size.height / 5,
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
              //Color(0xFF119A52),
              Color(0xFF0B6243),
              Color(0xFF021817),
            ],
            transform: GradientRotation(pi / 2),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SlideTransition(
                  position: littleFishAnimation, child: buildLittleFish()),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SlideTransition(
                  position: bigFishAnimation, child: buildBigFish()),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: buildLogo(),
            )
          ],
        ));
  }
}
