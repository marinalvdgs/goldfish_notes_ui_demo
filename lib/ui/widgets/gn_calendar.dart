import 'dart:math';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class GNCalendar extends StatefulWidget {
  @override
  _GNCalendarState createState() => _GNCalendarState();
}

const EdgeInsets calendarPadding =
    EdgeInsets.symmetric(vertical: 24, horizontal: 8);

class _GNCalendarState extends State<GNCalendar>
    with SingleTickerProviderStateMixin {
  DateTime selectedDay = DateTime.now();

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 64,
      firstDay: DateTime.utc(2010, 10, 16),
      focusedDay: selectedDay,
      lastDay: DateTime.utc(2030, 3, 14),
      headerVisible: false,
      daysOfWeekVisible: false,
      pageAnimationDuration: Duration(milliseconds: 300),
      pageAnimationCurve: Curves.fastLinearToSlowEaseIn,
      calendarFormat: CalendarFormat.week,
      weekendDays: [],
      availableCalendarFormats: {CalendarFormat.week: 'Week'},
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultTextStyle: TextStyle(fontSize: 16),
      ),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          _animationController.reset();
          _animationController.forward();
        });
      },
      calendarBuilders: CalendarBuilders(selectedBuilder: (context, date, _) {
        return FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: _animationController, curve: Curves.easeIn)),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF34EE9A),
                  Color(0xFF19D1AF),
                  Color(0xFF02BBBD),
                ],
                transform: GradientRotation(pi / 2),
              ),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        );
      }),
    );
  }
}
