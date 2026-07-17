import 'package:flutter/material.dart';
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

class OldDatesLines extends StatefulWidget implements PreferredSizeWidget {
  final MyDate date;
  final void Function() changeDatePlanner;
  final BoolControler isLoading;

  @override
  Size get preferredSize => const Size.fromHeight(180);

  const OldDatesLines(
    this.date,
    this.changeDatePlanner,
    this.isLoading, {
    super.key,
  });

  @override
  State<OldDatesLines> createState() => _OldDatesLinesState();
}

class _OldDatesLinesState extends State<OldDatesLines> {
  PageController controller = PageController(initialPage: 0);

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

  Widget buildRow() {
    var daysLabel = daysOfWeek(context);
    var week = widget.date.getWeek();

    String calenderLabel, greeting, dayLabel;
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
      dayLabel = calenderLabel;
    } else {
      dayLabel = "$greeting $calenderLabel";
    }
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (var i = 0; i <= 6; i++)
                  (i != widget.date.weekday())
                      ? InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(daysLabel[i]),
                              SizedBox(
                                height: 30,
                                child: Center(
                                  child: Text(week[i].day().toString()),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            changeDate(week[i].date);
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(daysLabel[i]),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  week[i].day().toString(),
                                  style: ThemeText.currentDay,
                                ),
                              ),
                            ),
                          ],
                        ),
              ],
            ),
          ),
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

  @override
  void initState() {
    super.initState();
  }

  void changeDate(DateTime newDate) {
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
