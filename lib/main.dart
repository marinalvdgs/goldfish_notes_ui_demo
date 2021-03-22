import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Goldfish Notes',
      home: SplashScreen(),
    );
  }
}
