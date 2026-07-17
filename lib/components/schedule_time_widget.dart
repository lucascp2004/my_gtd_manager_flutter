import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/controllers/schedule_time.dart';

import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/controllers/time_of_day_controller.dart';

// ignore: must_be_immutable
class ScheduleTimeWidget extends StatefulWidget {
  BoolControler flexible;
  TimeOfDayController startTime;
  TimeOfDayController endTime;
  ScheduleTimeWidget({
    required this.flexible,
    required this.startTime,
    required this.endTime,
    super.key,
  });

  @override
  State<ScheduleTimeWidget> createState() => _ScheduleTimeWidgetState();
}

class _ScheduleTimeWidgetState extends State<ScheduleTimeWidget> {
  Text endtime() {
    if (widget.endTime.value == null) {
      return Text(AppLocalizations.of(context)!.chooseTime);
    } else {
      return Text(widget.endTime.value!.format(context));
    }
  }

  chooseStartTime() async {
    getTime(widget.startTime.value!).then((pickedTime) async {
      if (pickedTime == null) {
        return;
      }
      if (widget.endTime.value != null) {
        if (isFirstTimeBeforeSecond(widget.endTime.value!, pickedTime)) {
          if (mounted) {
            await ShowMessages.showMessage(
              AppLocalizations.of(context)!.errStartAfterEnd,
              context,
            );
          }
        }
      }
      if (pickedTime != widget.startTime.value) {
        widget.startTime.value = pickedTime;
        setState(() {});
      }
    });
  }

  void chooseEndTime() async {
    getTime(widget.endTime.value ?? const TimeOfDay(hour: 8, minute: 0)).then((
      pickedTime,
    ) async {
      if (pickedTime == null) {
        return;
      }
      if (isFirstTimeBeforeSecond(pickedTime, widget.startTime.value!)) {
        if (mounted) {
          await ShowMessages.showMessage(
            AppLocalizations.of(context)!.errStartAfterEnd,
            context,
          );
        }
      }
      if (pickedTime != widget.endTime.value) {
        widget.endTime.value = pickedTime;
        setState(() {});
      }
    });
  }

  Future<TimeOfDay?> getTime(TimeOfDay initialTime) {
    return showTimePicker(context: context, initialTime: initialTime);
  }

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                key: const Key("flexible"),
                shape: const CircleBorder(),
                activeColor: Colors.blue,
                value: (widget.flexible.value == true),
                onChanged: (value) {
                  if (value == true) {
                    setState(() {
                      widget.flexible.value = true;
                    });
                  }
                  if (value == false) {
                    setState(() {
                      widget.flexible.value = false;
                    });
                  }
                },
              ),
              Text(AppLocalizations.of(context)!.flexibleStartTime),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.startTime),
                    InkWell(
                      key: const Key("startTime"),
                      onTap: chooseStartTime,
                      child: Text(widget.startTime.value!.format(context)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.endTime),
                    InkWell(
                      key: const Key("endTime"),
                      onTap: chooseEndTime,
                      child: endtime(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
