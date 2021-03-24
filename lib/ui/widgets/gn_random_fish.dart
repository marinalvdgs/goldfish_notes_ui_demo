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
      return 0 + getSweepAngle(dy2, false);
    else
      return pi / 2 + getSweepAngle(dy2, false);
  }
  if (dy1 == min && dy2 == max) {
    if (dx1 <= 0)
      return 3 * pi / 2 + getSweepAngle(dx2, false);
    else
      return 0 + getSweepAngle(dx2, false);
  }
  if (dy1 == max && dy2 == min) {
    if (dx1 <= 0)
      return pi + getSweepAngle(dx2, true);
    else
      return pi / 2 + getSweepAngle(dx2, true);
  }
}

double getSweepAngle(double dy, bool isDy) {
  if (dy.abs() > 1) dy = 1 - dy.abs();
  if (isDy) return pi / 2 * (1 + dy);
  return pi / 2 * dy.abs();
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
    final double x = widget.radius / widget.size.width / 2 + 0.2;
    final double y = widget.radius / widget.size.height;
    final candidates = [
      Tween(
        begin: Offset(random.nextDouble() + 0.2, -y),
        end: Offset(-random.nextDouble() - 0.2, y),
      ),
      Tween(
        begin: Offset(random.nextDouble() + 0.2, y),
        end: Offset(-random.nextDouble() - 0.2, -y),
      ),
      Tween(
        begin: Offset(x, random.nextDouble() + 0.2),
        end: Offset(-x, -random.nextDouble() - 0.2),
      ),
      Tween(
        begin: Offset(-x, random.nextDouble() + 0.2),
        end: Offset(x, -random.nextDouble() - 0.2),
      )
    ];

    var tween = candidates[random.nextInt(candidates.length - 1)];
    offsetAnimation = tween
        .animate(CurvedAnimation(parent: fishController, curve: Curves.linear));

    debugPrint('${candidates.indexOf(tween)} ${tween.begin}  ${tween.end}');
    double a = candidates.indexOf(tween) < 2 ? y : x;
    angle = getStartAngle(
            -a, a, tween.begin.dx, tween.end.dx, tween.begin.dy, tween.end.dy) +
        pi / 6;
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
