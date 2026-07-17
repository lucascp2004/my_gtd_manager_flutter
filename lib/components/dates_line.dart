import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/dates_lines_v2.dart';
import 'package:intl/intl.dart';
import 'package:my_gtd_manager_2/components/calendar_icon.dart';
import 'package:my_gtd_manager_2/components/calendar_icon2.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import '../controllers/my_date.dart';

List<String> daysOfWeek(BuildContext context) {
  return [
    AppLocalizations.of(context)!.monday,
    AppLocalizations.of(context)!.tuesday,
    AppLocalizations.of(context)!.wednesday,
    AppLocalizations.of(context)!.thursday,
    AppLocalizations.of(context)!.friday,
    AppLocalizations.of(context)!.saturday,
    AppLocalizations.of(context)!.sunday,
  ];
}
/*List<String> months(BuildContext context){
  return [
    AppLocalizations.of(context)!.january,
    AppLocalizations.of(context)!.february,
    AppLocalizations.of(context)!.march,
    AppLocalizations.of(context)!.april,
    AppLocalizations.of(context)!.may,
    AppLocalizations.of(context)!.june,
    AppLocalizations.of(context)!.july,
    AppLocalizations.of(context)!.august,
    AppLocalizations.of(context)!.september,
    AppLocalizations.of(context)!.october,
    AppLocalizations.of(context)!.november,
    AppLocalizations.of(context)!.december,
  ];
}*/

enum Situation { dontChange, oneWeekAgo, oneWeekLater, unknown }

class DatesLines extends StatefulWidget implements PreferredSizeWidget {
  final MyDate date;
  final void Function() changeDatePlanner;
  final BoolControler isLoading;

  @override
  Size get preferredSize => const Size.fromHeight(180);

  const DatesLines(
    this.date,
    this.changeDatePlanner,
    this.isLoading, {
    super.key,
  });

  @override
  State<DatesLines> createState() => _DatesLinesState();
}

class _DatesLinesState extends State<DatesLines> {
  Situation situation = Situation.unknown;
  @override
  void initState() {
    super.initState();
  }

  void chooseDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.date.date,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null) {
      changeDate(picked);
    }
  }

  String getMessage() {
    String calenderLabel, greeting;
    var dateNum = datetimeToInt(widget.date.date);
    var todayNum = datetimeToInt(DateTime.now());
    if (dateNum == todayNum) {
      greeting = AppLocalizations.of(context)!.today;
    } else if (dateNum == todayNum - 1) {
      greeting = AppLocalizations.of(context)!.yesterday;
    } else if (dateNum == todayNum + 1) {
      greeting = AppLocalizations.of(context)!.tomorrow;
    } else {
      greeting = "";
    }

    calenderLabel = DateFormat.yMMMMd(
      Localizations.localeOf(context).toString(),
    ).format(widget.date.date);

    if (greeting == "") {
      return calenderLabel;
    } else {
      return "$greeting $calenderLabel";
    }
  }

  Widget buildRow() {
    var daysLabel = daysOfWeek(context);

    String dayLabel = getMessage();

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dayLabel, style: ThemeText.datesLines),
            Row(
              children: [
                CalendarIcon(
                  widget.date.date.day,
                  chooseDate,

                  key: const Key("chooseDate"),
                ),
                const SizedBox(width: 5),
                CalendarIcon2(chooseDate),
              ],
            ),
          ],
        ),
        //const SizedBox(height: 10,),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.black, // Color of the border
                width: 1.0, // Thickness of the border
              ),
            ),
          ),
          child: OldDatesLines(
            widget.date,
            widget.changeDatePlanner,
            widget.isLoading,
          ),

          /*DatesLinePageView(
            changeDate,
            widget.date,
            daysLabel
          )*/
        ),
        //const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.yMd().format(widget.date.date),
              style: ThemeText.dayPlanner,
            ),
          ],
        ),
      ],
    );
  }

  void changeDate(DateTime newDate) {
    situation = Situation.dontChange;
    widget.date.setDate(newDate);
    setState(() {});
    widget.changeDatePlanner();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: SizedBox(height: 180, child: buildRow()),
      ),
    );
  }
}
