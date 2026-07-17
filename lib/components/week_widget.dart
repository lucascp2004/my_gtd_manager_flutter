import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

List<String> daysOfWeek(BuildContext context) {
  return [
    AppLocalizations.of(context)!.mondayInOneLetter,
    AppLocalizations.of(context)!.tuesdayInOneLetter,
    AppLocalizations.of(context)!.wednesdayInOneLetter,
    AppLocalizations.of(context)!.thursdayInOneLetter,
    AppLocalizations.of(context)!.fridayInOneLetter,
    AppLocalizations.of(context)!.saturdayInOneLetter,
    AppLocalizations.of(context)!.sundayInOneLetter,
  ];
}

class WeekLetterWidget extends StatefulWidget {
  final String text;
  final BoolControler controller;

  const WeekLetterWidget(this.text, this.controller, {super.key});

  @override
  State<WeekLetterWidget> createState() => _WeekLetterWidgetState();
}

class _WeekLetterWidgetState extends State<WeekLetterWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.controller.change();
        setState(() {});
      },
      child: Container(
        width: 30, // Diameter of the circle
        height: 30, // Diameter of the circle
        decoration: BoxDecoration(
          color: (widget.controller.value)
              ? Colors.blue
              : Colors.white, // Color of the circle
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text, // The letter inside the circle
          style: TextStyle(
            color: (widget.controller.value)
                ? Colors.white
                : Colors.blue, // Color of the letter
            // Size of the letter
          ),
        ),
      ),
    );
  }
}

class WeekWidget extends StatefulWidget {
  final List<BoolControler> weekdayList;
  final DateTime date;

  const WeekWidget(this.weekdayList, this.date, {super.key});

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  @override
  Widget build(BuildContext context) {
    var day = widget.date.weekday - 1;
    widget.weekdayList[day].setTrue();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
        7,
        (index) => WeekLetterWidget(
          daysOfWeek(context)[index],
          widget.weekdayList[index],
          key: Key("weekday $index"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i <= 6; i++) {
      widget.weekdayList[i].setFalse();
    }
    super.dispose();
  }
}
