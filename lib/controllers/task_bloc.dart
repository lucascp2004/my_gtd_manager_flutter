import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/controllers/task_block_events.dart';
import 'package:my_gtd_manager_2/controllers/task_parameters.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TaskBloc {
  late bool showAll;
  late List<TaskData> tasks;
  DateTime date = DateTime.now();

  final _streamDateController = StreamController<TaskBlocEvent>.broadcast();
  final _streamTasks = DatabaseDao.tasksStream();
  final _streamShowAll = DatabaseDao.showAllPlannerStream();

  TaskBloc() {
    getInitialData();
  }

  Stream<TaskBlocEvent> get stream {
    var streamDate = _streamDateController.stream;

    return StreamGroup.merge([_streamTasks, streamDate, _streamShowAll]);
  }

  Future<void> getInitialData() async {
    //showAll = ((await _streamShowAll.first) as ShowAllEvent).showAll;
    tasks = ((await _streamTasks.first) as TaskListEvent).tasks;
  }

  void setDate(DateTime newDate) {
    _streamDateController.add(DateChangeEvent(newDate));
    date = newDate;
  }

  List<TaskParameters> filterTasks() {
    List<TaskParameters> result = [];
    var filter1 = tasks
        .where((task) => DatabaseDao.filterTask(task, date))
        .toList();
    for (var task in filter1) {
      var checkDays = stringToListOfDates(task.checkDays).toList();
      bool checked = listHasDate(checkDays, date);

      if (showAll) {
        result.add(TaskParameters(task, checked));
      } else {
        if (!checked && !task.finished) {
          result.add(TaskParameters(task, checked));
        }
      }
    }

    result.sort();
    return result;
  }
}
