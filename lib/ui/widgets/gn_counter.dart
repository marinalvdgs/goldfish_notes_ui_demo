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
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 2),
              painter: CounterPainter(radius: radius),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: onCounterTap,
            child: Container(
              height: radius / 2 + 10,
              width: radius / 2 + 10,
              transform: Matrix4.translationValues(0, -10, 0),
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
          ),
        ),
      ],
    );
  }
}
