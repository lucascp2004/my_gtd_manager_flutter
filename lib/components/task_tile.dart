import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gtd_manager_2/components/completed_form_task.dart';
import 'package:my_gtd_manager_2/components/custom_list_tile.dart';
import 'package:my_gtd_manager_2/components/task_check_button.dart';
import 'package:my_gtd_manager_2/components/task_form.dart';
import 'package:my_gtd_manager_2/components/text_tile.dart';
import 'package:my_gtd_manager_2/components/theme/theme_colors.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';

String formatTimeOfDay(TimeOfDay? timeOfDay, BuildContext context) {
  if (timeOfDay == null) return "";
  final now = DateTime.now();
  final dt = DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
  final format = DateFormat.jm(
    Localizations.localeOf(context).toString(),
  ); // Uses the locale from the context
  return format.format(dt);
}

class TaskTile extends StatefulWidget {
  final DateTime plannerDate;
  final TaskData task;
  final int index;
  final bool isChecked;

  const TaskTile(
    this.task,
    this.index,
    this.isChecked,
    this.plannerDate, {
    super.key,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    var name = widget.task.name;
    var isChecked = widget.isChecked;
    var id = widget.task.id;
    var startTime = stringToTimeOfDay(widget.task.beginningTime);
    var endTime = stringToTimeOfDay(widget.task.endingTime);
    String time;
    if (widget.task.finished) {
      time = "Completed";
    } else if (widget.task.flexibleTime == false) {
      time =
          "${formatTimeOfDay(startTime, context)}-${formatTimeOfDay(endTime, context)}";
    } else {
      time = "Anytime";
    }

    var checkedOrFinished = (widget.isChecked || widget.task.finished);
    var color = checkedOrFinished ? MyColors.itemTileChecked : Colors.white;
    /*var textStyle1 =  checkedOrFinished?
        const TextStyle(
          fontSize: 15,
          color: Colors.white,
          
        ):
        const TextStyle(
          
          fontSize: 18,
        );
    var textStyle2 =  checkedOrFinished?
        const TextStyle(
          color: Colors.white,
          
        ):*/

    return Container(
      margin: const EdgeInsets.only(top: 4, left: 10, right: 10),
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[1],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),

        color: color,
      ),

      child: (CustomListTile(
        key: Key("${widget.task.name} ${widget.index}"),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextTile(name, textStyle: ThemeText.black16Size),
            TextTile(time, textStyle: ThemeText.timeLabel),
          ],
        ),

        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              if (widget.task.finished) {
                return CompletedTaskForm(widget.task);
              } else {
                return TaskForm(
                  startingDay: widget.plannerDate,
                  projectIdRelated: widget.task.relatedElementId,
                  task: widget.task,
                );
              }
            },
          );
        },

        leading: (widget.task.finished)
            ? null
            : TaskCheckButton(isChecked, id, "${widget.index} cb"),
      )),
    );
  }
}
