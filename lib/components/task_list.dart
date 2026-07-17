import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/task_tile.dart';
import 'package:my_gtd_manager_2/controllers/task_parameters.dart';

class TaskList extends StatelessWidget {
  final DateTime date;
  final List<TaskParameters> list;
  const TaskList(this.date, this.list, {super.key});
  void printVisualList() {
    debugPrint("Print Task Visual List");
    int index = -1;
    for (var task in list) {
      index++;
      debugPrint("index:$index ${task.task.name}");
    }
    debugPrint("Fim Task Print Visual List");
  }

  @override
  Widget build(BuildContext context) {
    printVisualList();
    return ListView.builder(
      key: const Key("dragging List"),
      physics: const AlwaysScrollableScrollPhysics(),

      itemCount: list.length,
      itemBuilder: (context, index) {
        return TaskTile(list[index].task, index, list[index].checked, date);
      },
    );
  }
}
