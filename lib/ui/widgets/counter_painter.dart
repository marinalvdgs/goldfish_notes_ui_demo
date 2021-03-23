import 'dart:math';

import 'package:flutter/material.dart';

const LinearGradient bgGradient = LinearGradient(
  colors: [
    Color(0xFF42C694),
    Color(0xFF0B6243),
  ],
  transform: GradientRotation(3 * pi / 4),
);

class CounterPainter extends CustomPainter {
  final double radius;

  CounterPainter({@required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerWidth = size.width / 2;
    final double centerHeight = size.height / 2;
    Paint bgPaint = Paint()
      ..shader = bgGradient
          .createShader(Rect.fromCircle(center: Offset.zero, radius: radius));
    Paint paint = Paint()..color = Color(0xffcdece4);
    Path bgPath = Path()
      ..moveTo(centerWidth - centerWidth / 3, centerHeight + radius - 10)
      ..quadraticBezierTo(
          centerWidth - 10, size.height, centerWidth - 45, size.height + 50)
      ..lineTo(centerWidth + 45, size.height + 50)
      ..quadraticBezierTo(centerWidth + 10, size.height,
          centerWidth + centerWidth / 3, centerHeight + radius - 10)
      ..lineTo(centerWidth - centerWidth / 3, centerHeight + radius - 10);
    canvas.drawPath(bgPath, paint);
    canvas.drawCircle(Offset(centerWidth, centerHeight), radius + 10, paint);
    canvas.drawCircle(Offset(centerWidth, centerHeight), radius, bgPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
