import 'dart:math';

import 'package:flutter/material.dart';

import '../splash_screen.dart';

double getSweepAngle(double shift) {
  bool isNeedToRecalculate = false;
  double shiftAngle = shift < 0.6
      ? pi / 8
      : shift < 0.9
          ? -pi / 4
          : -pi / 2;
  if (roundDouble(shift, 1).abs() >= 1) {
    isNeedToRecalculate = true;
    shift = 1 - shift.abs();
  }
  if (isNeedToRecalculate) {
    return pi / 2 * (1 - shift) - pi / 8;
  }
  return pi / 2 * shift.abs() + shiftAngle;
}

double roundDouble(double val, int places) {
  double mod = pow(10.0, places);
  return ((val * mod).round().toDouble() / mod);
}

class GNRandomFish extends StatefulWidget {
  final Random random;
  final Size size;
  final double radius;

  GNRandomFish(
      {@required this.random, @required this.size, @required this.radius});

  @override
  _GNRandomFishState createState() => _GNRandomFishState();
}

class _GNRandomFishState extends State<GNRandomFish>
    with SingleTickerProviderStateMixin {
  AnimationController fishController;
  Animation<Offset> offsetAnimation;
  double opacity;
  double randomNum;
  double height;
  double angle = pi;

  @override
  void initState() {
    Random random = widget.random;
    fishController =
        AnimationController(duration: Duration(seconds: 8), vsync: this)
          ..repeat(period: Duration(seconds: 5));
    randomNum = random.nextDouble();
    opacity = randomNum < 0.1 ? 1.0 : randomNum;
    height = random.nextDouble() * 100 + 25;
    final double x = roundDouble(widget.radius / widget.size.width, 1);
    final double y = roundDouble(widget.radius / widget.size.height, 1);

    var tween = Tween(
      begin: Offset(x + random.nextDouble(), -y),
      end: Offset(-x - random.nextDouble(), y),
    );
    offsetAnimation = tween
        .animate(CurvedAnimation(parent: fishController, curve: Curves.linear));

    angle = 0 + getSweepAngle(tween.end.dx);
    super.initState();
  }

  @override
  void dispose() {
    fishController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
        position: offsetAnimation,
        child: FittedBox(
          fit: BoxFit.none,
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: angle,
              child: Image.asset(
                fish,
                height: height,
              ),
            ),
          ),
        ));
  }
}
