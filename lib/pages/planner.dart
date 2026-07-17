import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/sanduich_menu_helpers.dart';
import 'package:my_gtd_manager_2/components/task_form.dart';
import 'package:my_gtd_manager_2/components/floating_action_button.dart';
import 'package:my_gtd_manager_2/components/planner_app_bar.dart';
import 'package:my_gtd_manager_2/components/planner_baseboard.dart';
import 'package:my_gtd_manager_2/components/planner_tasks.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/controllers/my_date.dart';
import 'package:my_gtd_manager_2/controllers/task_bloc.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

// ignore: must_be_immutable
class PlannerPage extends StatelessWidget {
  PlannerPage({super.key});
  BoolControler isLoading = BoolControler(false);

  MyDate date = MyDate(newDate: DateTime.now());

  String text = MyDate(newDate: DateTime.now()).toString();

  TaskBloc taskBloc = TaskBloc();

  void changeDatePlanner() async {
    isLoading.value = true;
    taskBloc.setDate(date.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlannerAppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        date: date,
        changeDatePlanner: changeDatePlanner,
        isLoading: isLoading,
      ),

      body: PlannerTasks(isLoading, taskBloc),
      drawer: MyDrawer(2),

      floatingActionButton: CustomFloatingActionButton(
        tooltip: AppLocalizations.of(context)!.taskPagetoolTip,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return TaskForm(
                projectIdRelated: null,
                startingDay: taskBloc.date,
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(child: const PlannerBaseBoard()),
    );
  }
}
