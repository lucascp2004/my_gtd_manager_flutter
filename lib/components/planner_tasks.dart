import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/function_provider.dart';
import 'package:my_gtd_manager_2/components/task_list.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/controllers/task_block_events.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/controllers/task_bloc.dart';

class PlannerTasks extends StatelessWidget {
  final BoolControler isLoading;
  final TaskBloc taskBloc;
  const PlannerTasks(this.isLoading, this.taskBloc, {super.key});

  Future<void> setCheckButtonValue(int taskId, bool value) async {
    if (value) {
      await DatabaseDao.checkTask(taskId, taskBloc.date);
    } else {
      await DatabaseDao.uncheckTask(taskId, taskBloc.date);
    }
  }

  @override
  Widget build(BuildContext context) {
    isLoading.value = true;

    return StreamBuilder<TaskBlocEvent>(
      stream: taskBloc.stream,
      builder: (context, snapshot) {
        isLoading.value = true;

        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If we run into an error, display it to the user
          isLoading.value = false;
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          if (snapshot.data is TaskListEvent) {
            taskBloc.tasks = (snapshot.data! as TaskListEvent).tasks;
          } else if (snapshot.data is ShowAllEvent) {
            taskBloc.showAll = (snapshot.data! as ShowAllEvent).showAll;
          } else if (snapshot.data is DateChangeEvent) {
            taskBloc.date = (snapshot.data! as DateChangeEvent).date;
          } else {
            throw Exception("Invalid Data");
          }

          if (snapshot.data == null) {
            isLoading.value = false;
            return const Text("Error");
          } else {
            isLoading.value = false;

            return FunctionProvider(
              sharedFunction: setCheckButtonValue,
              child: TaskList(taskBloc.date, taskBloc.filterTasks()),
            );
          }
        } else {
          isLoading.value = false;
          return const Text("Deu ruim");
        }
      },
    );
  }
}
