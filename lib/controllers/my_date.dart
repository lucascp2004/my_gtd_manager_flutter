import 'package:my_gtd_manager_2/controllers/dates_function.dart';

class MyDate {
  DateTime date;
  MyDate({required DateTime newDate}) : date = onlyDate(newDate);
  void setDate(DateTime newDate) {
    date = newDate;
  }

  void oneWeekLater() {
    date = date.add(const Duration(days: 7));
  }

  void oneWeekAgo() {
    date = date.subtract(const Duration(days: 7));
  }

  int weekday() => date.weekday - 1;
  int day() => date.day;

  List<MyDate> getWeek() {
    List<MyDate> result = [];
    var weekday = date.weekday;
    var startingDay = date.subtract(Duration(days: weekday - 1));
    for (int days = 0; days <= 6; days++) {
      result.add(MyDate(newDate: addDays(startingDay, days)));
    }
    return result;
  }

  DateTime firstWeekDay() {
    var weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  DateTime lastWeekDay() {
    var weekday = date.weekday;
    return date.add(Duration(days: 7 - weekday));
  }

  @override
  String toString() {
    var year = date.year;
    var month = date.month.toString().padLeft(2, '0');
    var day = date.day.toString().padLeft(2, '0');
    return "$year/$month/$day";
  }
}

DateTime onlyDate(DateTime date) {
  var year = date.year.toString();
  var month = date.month.toString().padLeft(2, '0');
  var day = date.day.toString().padLeft(2, '0');

  DateTime result = DateTime.parse('$year$month$day');
  return result;
}
