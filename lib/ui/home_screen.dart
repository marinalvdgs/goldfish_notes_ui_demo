import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_calendar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GNCalendar(),
        ],
      ),
    );
  }
}
