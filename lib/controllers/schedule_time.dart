import 'package:flutter/material.dart';

enum StartTimeType {flexible,fixed}
int convertToMinutes(TimeOfDay time) {
  return time.hour * 60 + time.minute;
}

bool isFirstTimeBeforeSecond(TimeOfDay first, TimeOfDay second) {
  return convertToMinutes(first) < convertToMinutes(second);
}
class ScheduleTime{
   bool flexibleTime=false;
   TimeOfDay startTime = const TimeOfDay(hour: 8, minute: 0);
   TimeOfDay? endTime;
   ScheduleTime({required this.flexibleTime, required this.startTime,required this.endTime});


}