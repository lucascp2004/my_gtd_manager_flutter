import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:flutter/material.dart';

class TaskParameters implements Comparable<TaskParameters> {
  TaskData task;
  bool checked;
  TaskParameters(this.task, this.checked);
  int timeOfDayNum(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  @override
  int compareTo(TaskParameters other) {
    var firstFlexibleTime = task.flexibleTime;
    var secondFlexibleTime = other.task.flexibleTime;
    var firstBeginningTime = stringToTimeOfDay(task.beginningTime);
    var secondBeginningTime = stringToTimeOfDay(other.task.beginningTime);
    var firstCreationTime = stringToDateTime(task.creationTime)!;
    var secondCreationTime = stringToDateTime(other.task.creationTime)!;
    if (!firstFlexibleTime) {
      if (secondFlexibleTime) {
        return 1;
      } else if (timeOfDayNum(firstBeginningTime!) ==
          timeOfDayNum(secondBeginningTime!)) {
        var result = firstCreationTime.compareTo(secondCreationTime);

        return result;
      } else {
        var result = timeOfDayNum(
          firstBeginningTime,
        ).compareTo(timeOfDayNum(secondBeginningTime));

        return result;
      }
    } else {
      if (secondFlexibleTime) {
        var result = (firstCreationTime).compareTo(secondCreationTime);

        return result;
      } else {
        return -1;
      }
    }
  }

  @override
  String toString() {
    var startTime = stringToTimeOfDay(task.beginningTime);
    var startTimeStr = (task.flexibleTime) ? 'flexible' : startTime.toString();
    return '''Task: ${task.name}
    StartTime: $startTimeStr''';
  }
}
