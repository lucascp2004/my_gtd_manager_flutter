import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/delete_element_button.dart';
import 'package:my_gtd_manager_2/components/dropdraw.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/components/save_button.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/schedule_time_widget.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/components/week_widget.dart';
import 'package:my_gtd_manager_2/controllers/task_controller.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TaskForm extends StatefulWidget {
  final TaskData? task;
  final DateTime startingDay;
  final int? projectIdRelated;
  final String? initialName;

  const TaskForm({
    required this.startingDay,
    required this.projectIdRelated,
    this.task,
    this.initialName,
    super.key,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late TaskController taskController;

  @override
  initState() {
    taskController = TaskController(
      widget.task,
      widget.startingDay,
      widget.projectIdRelated,
    );
    if (widget.task == null) {
      taskController.nameInput.text = widget.initialName ?? '';
    }
    super.initState();
  }

  Future<void> _onpressed() async {
    return taskController.action();
  }

  void onpressed() async {
    if (taskController.nameInput.text.trim() == "") {
      await ShowMessages.showMessage(
        AppLocalizations.of(context)!.typeNameForTaskError,
        context,
      );
      return;
    }

    _onpressed().then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  void changeDateTask() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskController.dateTask,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null && picked != taskController.dateTask) {
      setState(() {
        taskController.dateTask = picked;
      });
    }
  }

  void customRepeatFunc() {
    setState(() {});
  }

  Widget customWidget() {
    if (taskController.repeatType.value != 5) {
      return Container();
    }

    return Column(
      children: [
        Text(AppLocalizations.of(context)!.repeatEvery),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                key: const Key("repeatInput"),
                onSubmitted: (value) {},
                controller: taskController.customRepeatInput,
                keyboardType: TextInputType.number, // Use number input type
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Only accept digits
                  LengthLimitingTextInputFormatter(3), // Limit to 3 characters
                ],
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              fit: FlexFit.tight,
              child: MyDropdown(
                {
                  AppLocalizations.of(context)!.day: 1,
                  AppLocalizations.of(context)!.week: 2,
                  AppLocalizations.of(context)!.month: 3,
                  AppLocalizations.of(context)!.year: 4,
                },
                taskController.customRepeatController,
                afterSetState: () {
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        (taskController.customRepeatController.value == 2)
            ? WeekWidget(taskController.weekdayList, taskController.dateTask)
            : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var title = (widget.task != null)
        ? AppLocalizations.of(context)!.changeTask
        : AppLocalizations.of(context)!.addTask;
    var formatter = DateFormat.yMd();
    String formattedDate = formatter.format(taskController.dateTask);
    return AlertDialog(
      key: const Key("TaskForm"),
      title: Text(title),
      actions: [
        const CancelButton(),
        SaveButton(onPressed: onpressed),
      ],

      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                key: const Key("taskInput"),
                controller: taskController.nameInput,
                /*onSubmitted: (value) {
                  onpressed();
                },*/
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.dateTasK),
                  InkWell(
                    key: const Key("datePicker"),
                    onTap: changeDateTask,

                    child: Text(formattedDate),
                  ),
                ],
              ),
              ScheduleTimeWidget(
                flexible: taskController.flexibleTime,
                startTime: taskController.startTime,
                endTime: taskController.endTime,
              ),

              const SizedBox(height: 10),
              NotesWidget(notesInput: taskController.notes),
              const SizedBox(height: 10),
              (widget.task != null)
                  ? //if change task
                    IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ContainerWithBorder(
                            child: TextButton(
                              child: Text(
                                AppLocalizations.of(context)!.finishTask,
                                style: ThemeText.darkblueLabelButton,
                              ),
                              onPressed: () {
                                DatabaseDao.finishTask(
                                  taskId: widget.task!.id,
                                  date: widget.startingDay,
                                  projectId: widget.task!.relatedElementId,
                                ).then((_) {
                                  if (context.mounted) Navigator.pop(context);
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          DeleteElementButton(
                            id: widget.task!.id,
                            hasRelatedItems:
                                widget.task!.relatedElementId != null,
                            projectIdRelated: widget.task!.relatedElementId,
                            type: ElementType.task,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )
                  : Container(),

              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.repeat),
                  const SizedBox(width: 30),
                  Flexible(
                    fit: FlexFit.tight,
                    child: MyDropdown(
                      {
                        AppLocalizations.of(context)!.noRepeat: 0,
                        AppLocalizations.of(context)!.everDay: 1,
                        AppLocalizations.of(context)!.everWeek: 2,
                        AppLocalizations.of(context)!.everMonth: 3,
                        AppLocalizations.of(context)!.everYear: 4,
                        AppLocalizations.of(context)!.customRepeat: 5,
                      },
                      taskController.repeatType,
                      afterSetState: customRepeatFunc,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              customWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
