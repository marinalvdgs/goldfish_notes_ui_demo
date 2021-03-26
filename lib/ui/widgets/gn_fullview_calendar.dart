import 'package:flutter/material.dart';
import 'package:goldfish_notes_ui_demo/ui/widgets/gn_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class GNFullViewCalendar extends StatefulWidget {
  final DateTime selectedDay;
  final Function onDayTap;
  final Animation<double> opacity;

  GNFullViewCalendar(
      {@required this.selectedDay,
      @required this.onDayTap,
      @required this.opacity});

  @override
  _GNFullViewCalendarState createState() => _GNFullViewCalendarState();
}

class _GNFullViewCalendarState extends State<GNFullViewCalendar> {
  DateTime currentDay;

  @override
  void initState() {
    currentDay = widget.selectedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              focusedDay: currentDay,
              lastDay: DateTime.utc(2030, 3, 14),
              weekendDays: [],
              availableCalendarFormats: {CalendarFormat.month: ''},
              calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
              ),
              selectedDayPredicate: (day) {
                return isSameDay(currentDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                widget.onDayTap(selectedDay);
                setState(() {
                  currentDay = selectedDay;
                });
              },
              calendarBuilders:
                  CalendarBuilders(selectedBuilder: (context, date, _) {
                return FadeTransition(
                  opacity: widget.opacity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: dayGradient,
                      shape: BoxShape.circle,
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
        ),
      ),
    );
  }
}
