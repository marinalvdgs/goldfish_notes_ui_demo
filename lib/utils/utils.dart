import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

String getWeekDay(DateTime date){
  DateTime today = DateTime.now();
  if(isSameDay(date, today)) return 'Today';
  if(isSameDay(date, today.add(Duration(days: 1)))) return 'Tomorrow';
  if(isSameDay(date, today.add(Duration(days: -1)))) return 'Yesterday';
  return DateFormat.EEEE().format(date);
}