import 'dart:math';

import 'package:flutter/material.dart';

class SeaweedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Color(0x669FD5B1),
            Color(0x6642C694),
            Color(0x66119A52),
            Color(0x660B6243),
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
}
