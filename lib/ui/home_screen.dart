import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_calendar.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_counter.dart';
import 'package:goldfish_notes_ui_demo/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now();
  int count = 0;

  void onDayChange(DateTime day) {
    setState(() {
      selectedDay = day;
    });
  }

  void onCountChange() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '${getWeekDay(selectedDay)}\'s Diary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              '$count diaries',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Flexible(
              child: GNCounter(
            onCountChange: onCountChange,
          )),
          GNCalendar(
            onDayChange: onDayChange,
          ),
        ],
      ),
    );
  }
}
