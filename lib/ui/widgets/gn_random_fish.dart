import 'dart:math';

import 'package:flutter/material.dart';

import '../splash_screen.dart';

double getStartAngle(
    double min, double max, double dx1, double dx2, double dy1, double dy2) {
  if (dx1 == min && dx2 == max) {
    if (dy1 <= 0)
      return 3 * pi / 2 + getSweepAngle(dy2, false);
    else
      return pi + getSweepAngle(dy2, true);
  }
  if (dx1 == max && dx2 == min) {
    if (dy1 <= 0)
      return 0 + getSweepAngle(dy2, true);
    else
      return pi / 2 + getSweepAngle(dy2, false);
  }
  if (dy1 == min && dy2 == max) {
    if (dx1 <= 0)
      return 3 * pi / 2 + getSweepAngle(dx2, true);
    else
      return 0 + getSweepAngle(dx2, false);
  }
  if (dy1 == max && dy2 == min) {
    if (dx1 <= 0)
      return pi + getSweepAngle(dx2, false);
    else
      return pi / 2 + getSweepAngle(dx2, true);
  }
}

double getSweepAngle(double shift, bool isNeedToRecalculate) {
  if (shift.floorToDouble().abs() > 1) {
    isNeedToRecalculate = false;
    shift = 1 - shift.abs();
  }
  if (isNeedToRecalculate) return pi / 2 * (1 + shift);
  return pi / 2 * shift.abs();
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
        AnimationController(duration: Duration(seconds: 3), vsync: this)
          ..repeat();
    randomNum = random.nextDouble();
    opacity = randomNum < 0.1 ? 1.0 : randomNum;
    height = random.nextDouble() * 100 + 25;
    final double x = roundDouble(widget.radius / widget.size.width, 1);
    final double y = roundDouble(widget.radius / widget.size.height, 1);

    final candidates = [
      Tween(
        begin: Offset(x + random.nextDouble(), -y),
        end: Offset(-x - random.nextDouble(), y),
      ),
      Tween(
        begin: Offset(x + random.nextDouble(), y),
        end: Offset(-x - random.nextDouble(), -y),
      ),
      Tween(
        begin: Offset(x, random.nextDouble() + y),
        end: Offset(-x, -random.nextDouble() - y),
      ),
      Tween(
        begin: Offset(-x, random.nextDouble() + y),
        end: Offset(x, -random.nextDouble() - y),
      )
    ];

    var tween = candidates[random.nextInt(10000) % 4];
    offsetAnimation = tween
        .animate(CurvedAnimation(parent: fishController, curve: Curves.linear));

    debugPrint('${candidates.indexOf(tween)} ${tween.begin}  ${tween.end}');
    double a = candidates.indexOf(tween) < 2 ? y : x;
    angle = getStartAngle(
            -a, a, tween.begin.dx, tween.end.dx, tween.begin.dy, tween.end.dy) +
        pi / 8;
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
