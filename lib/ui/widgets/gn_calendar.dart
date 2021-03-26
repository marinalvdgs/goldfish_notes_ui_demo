import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_fullview_calendar.dart';
import 'package:goldfish_notes_ui_demo/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

const LinearGradient dayGradient = LinearGradient(
  colors: [
    Color(0xFF34EE9A),
    Color(0xFF19D1AF),
    Color(0xFF02BBBD),
  ],
  transform: GradientRotation(pi / 2),
);

class GNCalendar extends StatefulWidget {
  @override
  _GNCalendarState createState() => _GNCalendarState();
}

class _GNCalendarState extends State<GNCalendar>
    with SingleTickerProviderStateMixin {
  DateTime selectedDay = DateTime.now();

  AnimationController _animationController;
  Animation opacityAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onDayTap(DateTime day) {
    if (!isSameDay(selectedDay, day)) {
      setState(() {
        selectedDay = day;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  String getMonthABBR() {
    return DateFormat.MMM().format(selectedDay);
  }

  void onDateTap() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return GNFullViewCalendar(
              selectedDay: selectedDay,
              onDayTap: onDayTap,
              opacity: opacityAnimation);
        });
  }

  Widget buildDateBlock() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Material(
          color: Colors.transparent,
          type: MaterialType.circle,
          child: InkWell(
            onTap: onDateTap,
            splashColor: Color(0x3342C694),
            highlightColor: Color(0x2242C694),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${selectedDay.day}',
                    style: TextStyle(fontSize: 45),
                  ),
                  SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.grey.shade300,
                        endIndent: 8,
                        indent: 8,
                      )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${getWeekDay(selectedDay)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${getMonthABBR().toUpperCase()} / ${selectedDay.year}',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildDateBlock(),
        TableCalendar(
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
            outsideTextStyle: TextStyle(fontSize: 16),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) => onDayTap(selectedDay),
          calendarBuilders:
              CalendarBuilders(selectedBuilder: (context, date, _) {
            return FadeTransition(
              opacity: opacityAnimation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  gradient: dayGradient,
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
        ),
      ],
    );
  }
}
