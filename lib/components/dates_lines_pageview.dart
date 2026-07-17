import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/days_week_with_number.dart';
import 'package:my_gtd_manager_2/controllers/my_date.dart';

class DatesLinePageView extends StatefulWidget {
  const DatesLinePageView(this.action, this.date, this.daysLabel, {super.key});
  final MyDate date;

  final List<String> daysLabel;
  final Function(DateTime) action;

  @override
  State<DatesLinePageView> createState() => _DatesLinePageViewState();
}

class _DatesLinePageViewState extends State<DatesLinePageView> {
  late int currentIndex;
  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  MyDate oneWeekAgo() {
    return MyDate(newDate: widget.date.date.subtract(const Duration(days: 7)));
  }

  MyDate oneWeekLater() {
    return MyDate(newDate: widget.date.date.add(const Duration(days: 7)));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      //padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (var cont = 0; cont <= 6; cont++)
            DayWeekWithNumber(
              widget.date.getWeek()[cont],
              widget.daysLabel[cont],
              widget.action,
              widget.date.getWeek()[cont].weekday() != widget.date.weekday(),
            ),
        ],
      ),
    );
  }
}
