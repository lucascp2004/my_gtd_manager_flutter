import 'package:my_gtd_manager_2/database/database.dart';

abstract class TaskBlocEvent {}

class TaskListEvent extends TaskBlocEvent {
  final List<TaskData> tasks;

  TaskListEvent(this.tasks);
}

class ShowAllEvent extends TaskBlocEvent {
  final bool showAll;

  ShowAllEvent(this.showAll);
  @override
  String toString() {
    return '''
      ShowAllEvent String
      value:$showAll
    ''';
  }
}

class DateChangeEvent extends TaskBlocEvent {
  final DateTime date;

  DateChangeEvent(this.date);
}
