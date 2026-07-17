import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/number_with_circle.dart';
import 'package:my_gtd_manager_2/controllers/my_date.dart';

class DayWeekWithNumber extends StatelessWidget {
  const DayWeekWithNumber(
    this.date,
    this.weekday,
    this.action,
    this.currentDay, {
    super.key,
  });
  final MyDate date;
  final String weekday;
  final void Function(DateTime) action;
  final bool currentDay;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (currentDay)
          ? null
          : () {
              action(date.date);
            },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(date.date.day.toString()),
          (!currentDay)
              ? SizedBox(height: 30, child: Center(child: Text(weekday)))
              : NumberWithCicle(weekday),
        ],
      ),
    );
  }
}
