import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';
import 'package:my_gtd_manager_2/controllers/time_of_day_controller.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class InvalidNumber implements Exception {
  final String message;

  InvalidNumber(this.message);

  @override
  String toString() {
    return "InvalidNumber: $message";
  }
}

class InvalidWeek implements Exception {
  final String message;

  InvalidWeek(this.message);

  @override
  String toString() {
    return "InvalidNumber: $message";
  }
}

class TaskController {
  TextEditingController nameInput = TextEditingController();
  TextEditingController customRepeatInput = TextEditingController();
  late DateTime dateTask;
  int? projectId;
  int? taskId;

  BoolControler flexibleTime = BoolControler(false);
  TimeOfDayController startTime = TimeOfDayController(
    value: const TimeOfDay(hour: 8, minute: 0),
  );
  TimeOfDayController endTime = TimeOfDayController();
  TextEditingController notes = TextEditingController();
  IntController repeatType = IntController();
  IntController customRepeatController = IntController(initialValue: 1);
  List<BoolControler> weekdayList = List.generate(
    7,
    (_) => BoolControler(false),
  );
  late bool changeTask;
  late String creationTime;

  TaskController(TaskData? task, DateTime date, int? projectId) {
    if (task == null) {
      creationTime = "";
      changeTask = false;
      dateTask = date;
      this.projectId = projectId;

      return;
    }
    creationTime = task.creationTime;
    taskId = task.id;
    changeTask = true;
    projectId = task.relatedElementId;
    nameInput.text = task.name;
    dateTask = stringToDateTime(task.startingDay)!;
    if (task.customRepeat) {
      repeatType.value = 5;
      customRepeatController.value = task.repeatType;
      if (task.repeatType == 2) {
        changeWeekPart(task.weekly!, customRepeatInput);
        return;
      }
      Map<int, int?> customRepeatValues = {
        1: task.daily,

        3: task.monthly,
        4: task.yearly,
      };
      customRepeatInput.text = customRepeatValues[task.repeatType]!.toString();
      return;
    }
    //it's not custom repeat
    repeatType.value = task.repeatType;
    if (!task.flexibleTime) {
      flexibleTime.value = false;
      startTime.value = stringToTimeOfDay(task.beginningTime)!;
      endTime.value = stringToTimeOfDay(task.endingTime);
    } else {
      flexibleTime.value = true;
    }
  }

  void changeWeekPart(String weekValue, TextEditingController? input) {
    var twoParts = weekValue.split('#');
    var part1 = twoParts[0];
    var part2 = twoParts[1];
    if (input != null) {
      input.text = part1;
    }
    for (var index = 0; index < 7; index++) {
      weekdayList[index].value = (part2[index] == '0') ? false : true;
    }
  }

  String getWeekValue() {
    String part1, part2;
    if (repeatType.value == 2) {
      part1 = '1';
    } else {
      part1 = customRepeatInput.text;
    }
    part2 = weekdayList.map<String>((day) => (day.value) ? "1" : "0").join('');
    return '$part1#$part2';
  }

  Future<void> action() async {
    dynamic repeatValue;
    int finalRepeatType;

    if (repeatType.value != 5) {
      if (repeatType.value == 0) {
        repeatValue = 0;
      } else {
        repeatValue = (repeatType.value == 2) ? getWeekValue() : 1;
      }

      finalRepeatType = repeatType.value;
    } else {
      int customRepeatNumber = int.parse(customRepeatInput.text);
      if (customRepeatNumber < 1) {
        throw InvalidNumber("repeat value invalid");
      }
      repeatValue = (customRepeatController.value == 2)
          ? getWeekValue()
          : customRepeatNumber;

      finalRepeatType = customRepeatController.value;
    }
    if (finalRepeatType == 2 && repeatType.value == 5) {
      var hasError = true;
      for (var day in weekdayList) {
        if (day.value == true) hasError = false;
      }
      if (hasError) throw InvalidWeek("No week days");
    }

    var task = TaskCompanion.insert(
      relatedElementId: Value(projectId),
      notes: notes.text,
      name: nameInput.text,
      lastModified: datetimeToString(DateTime.now()),
      creationTime: (changeTask)
          ? creationTime
          : datetimeToString(DateTime.now()),
      startingDay: (datetimeToString(dateTask)),
      flexibleTime: flexibleTime.value,
      beginningTime: Value(timeOfDayToString(startTime.value)),
      endingTime: Value(timeOfDayToString(endTime.value)),
      repeatType: finalRepeatType,
      customRepeat: repeatType.value == 5,
      daily: (finalRepeatType == 1)
          ? Value(repeatValue as int)
          : const Value(null),
      weekly: (finalRepeatType == 2)
          ? Value(repeatValue as String)
          : const Value(null),
      monthly: (finalRepeatType == 3)
          ? Value(repeatValue as int)
          : const Value(null),
      yearly: (finalRepeatType == 4)
          ? Value(repeatValue as int)
          : const Value(null),
    );
    if (changeTask) {
      await DatabaseDao.changeTask(task: task, taskId: taskId!);
    } else {
      await DatabaseDao.addTask(task: task);
    }
  }
}
