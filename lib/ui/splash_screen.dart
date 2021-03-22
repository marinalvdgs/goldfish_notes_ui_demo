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
  Animation<Offset> bubbleAnimation;
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
    bubbleAnimation = Tween<Offset>(
            begin: Offset(0.0, 1.0), end: Offset(0.0, -0.85))
        .animate(CurvedAnimation(parent: fishController, curve: Curves.linear));
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
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
            border: Border.all(color: Colors.white, width: 3),
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

  Widget buildBubble() {
    return FittedBox(
      fit: BoxFit.none,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: Image.asset(
          'assets/bubble.png',
          height: 20,
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

  Widget buildAnimatedChild(Animation<Offset> animation, Widget child) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SlideTransition(position: animation, child: child),
    );
  }

  Widget buildSeaweed() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Color(0xFF9FD5B1).withOpacity(0.4),
            Color(0xFF42C694).withOpacity(0.4),
            Color(0xFF119A52).withOpacity(0.4),
            Color(0xFF0B6243).withOpacity(0.4),
          ],
          transform: GradientRotation(pi / 4),
        ).createShader(bounds);
      },
      child: Image.asset(
        'assets/seaweed.png',
        height: MediaQuery.of(context).size.height * 0.65,
      ),
    );
  }

  List<Widget> buildRightBubbles(double width) {
    return [
      Positioned(
          bottom: 0,
          right: -width / 4 - 10,
          child: buildAnimatedChild(bubbleAnimation, buildBubble())),
      Positioned(
          bottom: -40,
          right: -width / 4,
          child: buildAnimatedChild(bubbleAnimation, buildBubble()))
    ];
  }

  List<Widget> buildLeftBubbles(double width) {
    return [
      Positioned(
          bottom: -130,
          right: width / 4,
          child: buildAnimatedChild(bubbleAnimation, buildBubble())),
      Positioned(
          bottom: -170,
          right: width / 4 - 20,
          child: buildAnimatedChild(bubbleAnimation, buildBubble())),
      Positioned(
          bottom: -190,
          right: width / 4 + 20,
          child: buildAnimatedChild(bubbleAnimation, buildBubble()))
    ];
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF42C694),
              Color(0xFF0B6243),
              Color(0xFF021817),
            ],
            transform: GradientRotation(pi / 2),
          ),
        ),
        child: Stack(
          children: [
            buildAnimatedChild(littleFishAnimation, buildLittleFish()),
            Positioned(
                bottom: -40,
                right: -210,
                child: Transform.scale(scale: 1.25, child: buildSeaweed())),
            Positioned(
                bottom: -80,
                left: -180,
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: buildSeaweed())),
            ...buildRightBubbles(width),
            ...buildLeftBubbles(width),
            buildAnimatedChild(bigFishAnimation, buildBigFish()),
            Align(
              alignment: Alignment.topCenter,
              child: buildLogo(),
            )
          ],
        ));
  }
}
