import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/counter_painter.dart';

class GNCounter extends StatefulWidget {
  @override
  _GNCounterState createState() => _GNCounterState();
}

class _GNCounterState extends State<GNCounter> {
  int count = 0;

  void onCounterTap() {
    setState(() {
      count++;
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

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width / 2 - 50;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 2),
                  painter: CounterPainter(radius: radius),
                ),
                buildAnimatedCount(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: buildCounterButton(radius),
        ),
      ],
    );
  }
}
