import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/completed_form_task.dart';
import 'package:my_gtd_manager_2/components/error_dialog.dart';
import 'package:my_gtd_manager_2/components/task_form.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TaskForm2 extends StatefulWidget {
  final int taskId;

  const TaskForm2(this.taskId, {super.key});
  @override
  State<TaskForm2> createState() => _TaskForm2();
}

class _TaskForm2 extends State<TaskForm2> {
  late TaskData task;
  Future<TaskData> getData() async {
    return await DatabaseDao.getTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AlertDialog(content: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return errorDialog(context);
        } else {
          task = snapshot.data!;
          if (task.finished) return CompletedTaskForm(task);
          return TaskForm(
            task: task,
            startingDay: stringToDateTime(task.startingDay)!,
            projectIdRelated: task.relatedElementId,
          );
        }
      },
    );
  }
}
