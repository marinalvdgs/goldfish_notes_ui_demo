import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/counter_painter.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_random_fish.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/seaweed_image.dart';

class GNCounter extends StatefulWidget {
  final Function onCountChange;
  GNCounter({@required this.onCountChange});
  @override
  _GNCounterState createState() => _GNCounterState();
}

class _GNCounterState extends State<GNCounter>
    with SingleTickerProviderStateMixin {
  AnimationController bubbleController;
  Animation<Offset> bubbleAnimation;
  Animation<double> fadeAnimation;
  int count = 0;

  @override
  void initState() {
    bubbleController =
        AnimationController(duration: Duration(seconds: 4), vsync: this)
          ..repeat();
    bubbleAnimation = Tween<Offset>(
            begin: Offset(-0.2, 0.7), end: Offset(-0.2, -0.8))
        .animate(
            CurvedAnimation(parent: bubbleController, curve: Curves.linear));
    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: bubbleController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    bubbleController.dispose();
    super.dispose();
  }

  void onCounterTap() {
    setState(() {
      count++;
      widget.onCountChange();
    });
  }

  Widget buildAnimatedCount() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        // transitionBuilder:
        //     (Widget child, Animation<double> animation) {
        //   return ScaleTransition(child: child, scale: animation);
        // },
        child: ShaderMask(
          key: ValueKey<int>(count),
          shaderCallback: (Rect bound) => LinearGradient(
            colors: [
              Color(0xff42d19c),
              Color(0xbb1ab489),
              Color(0x9900906f),
            ],
            transform: GradientRotation(pi / 2),
          ).createShader(bound),
          child: Text(
            '$count',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 150,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget buildCounterButton(double radius) {
    return GestureDetector(
      onTap: onCounterTap,
      child: Container(
        height: radius / 2 + 10,
        width: radius / 2 + 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Color(0xffffa101),
              Color(0xffff7a01),
            ],
            stops: [0.3, 1.0],
            transform: GradientRotation(3 * pi / 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x77ff7a01),
              offset: Offset(0.0, 6.0),
              blurRadius: 5,
            ),
          ],
        ),
        child: Icon(
          Icons.brush_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget buildClippedContainer({Widget child, Size size, double radius}) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height / 2 - radius),
        clipBehavior: Clip.hardEdge,
        height: radius * 2,
        width: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: child,
      ),
    );
  }

  Widget buildBubble({double height = 20}) {
    return SlideTransition(
      position: bubbleAnimation,
      child: FittedBox(
        fit: BoxFit.none,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Image.asset(
            'assets/bubble.png',
            height: height,
          ),
        ),
      ),
    );
  }

  Widget buildBubbles(Size size, double radius) {
    return Stack(
      children: [
        buildClippedContainer(size: size, radius: radius, child: buildBubble()),
        buildClippedContainer(
            size: size,
            radius: radius,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 32),
              child: buildBubble(),
            )),
        buildClippedContainer(
            size: size,
            radius: radius,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 64),
              child: buildBubble(),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width / 2 - 50;
    final Size size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    Random random = Random();
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CustomPaint(
                    size: size,
                    painter: CounterPainter(radius: radius),
                  ),
                  buildAnimatedCount(),
                  buildClippedContainer(
                      size: size,
                      radius: radius,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: radius + 32, top: radius / 3),
                        child: buildBubble(height: 12),
                      )),
                  buildClippedContainer(
                      size: size,
                      radius: radius,
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: -radius / 2,
                              right: -radius,
                              child: SeaweedImage()),
                        ],
                      )),
                  buildBubbles(size, radius),
                  for (int i = 0; i < count; i++)
                    buildClippedContainer(
                      child: GNRandomFish(
                        random: random,
                        size: size,
                        radius: radius,
                      ),
                      radius: radius,
                      size: size,
                    )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildCounterButton(radius),
          ),
        ],
      ),
    );
  }
}
