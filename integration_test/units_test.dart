/*import 'package:flutter/foundation.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:test/test.dart';
// Import the file where the Calculator class is located

void main() {
  group('Datase', () {
    test('filterTask ', () {
      final task1 = TaskData(
        tags: "",
        finishDay: "",
        finished: false,
        notes: "",
        id: 1,
        creationTime: datetimeToString(DateTime.now()),
        name: "task1",
        startingDay: datetimeToString(DateTime(2024, 1, 30)),
        flexibleTime: true,
        repeatType: 2,
        active: true,
        checkDays: "",
        lastModified: datetimeToString(DateTime.now()),
        weekly: "1#0101001",
        customRepeat: true,
      );
      var weeklyStr = task1.weekly!.split("#")[1];
      List<bool> weekly = [];
      for (var char in weeklyStr.split('')) {
        if (char == '1') {
          weekly.add(true);
        } else {
          weekly.add(false);
        }
      }
      var initialDate = DateTime(2024, 1, 30);
      //termina 24/05 sexta
      for (int daysToAdd = 0; daysToAdd <= 115; daysToAdd++) {
        var dates = [
          DateTime(2024, 01, 30),
          DateTime(2024, 02, 01),
          DateTime(2024, 02, 04),
          DateTime(2024, 02, 06),
          DateTime(2024, 02, 08),
          DateTime(2024, 02, 11),
          DateTime(2024, 02, 13),
          DateTime(2024, 02, 15),
          DateTime(2024, 02, 18),
          DateTime(2024, 02, 20),
          DateTime(2024, 02, 22),
          DateTime(2024, 02, 25),
          DateTime(2024, 02, 27),
          DateTime(2024, 02, 29),
          DateTime(2024, 03, 03),
          DateTime(2024, 03, 05),
          DateTime(2024, 03, 07),
          DateTime(2024, 03, 10),
          DateTime(2024, 03, 12),
          DateTime(2024, 03, 14),
          DateTime(2024, 03, 17),
          DateTime(2024, 03, 19),
          DateTime(2024, 03, 21),
          DateTime(2024, 03, 24),
          DateTime(2024, 03, 26),
          DateTime(2024, 03, 28),
          DateTime(2024, 03, 31),
          DateTime(2024, 04, 02),
          DateTime(2024, 04, 04),
          DateTime(2024, 04, 07),
          DateTime(2024, 04, 09),
          DateTime(2024, 04, 11),
          DateTime(2024, 04, 14),
          DateTime(2024, 04, 16),
          DateTime(2024, 04, 18),
          DateTime(2024, 04, 21),
          DateTime(2024, 04, 23),
          DateTime(2024, 04, 25),
          DateTime(2024, 04, 28),
          DateTime(2024, 04, 30),
          DateTime(2024, 05, 02),
          DateTime(2024, 05, 05),
          DateTime(2024, 05, 07),
          DateTime(2024, 05, 09),
          DateTime(2024, 05, 12),
          DateTime(2024, 05, 14),
          DateTime(2024, 05, 16),
          DateTime(2024, 05, 19),
          DateTime(2024, 05, 21),
          DateTime(2024, 05, 23),
        ];
        var day = addDays(initialDate, daysToAdd);

        if (dates.indexWhere((date) => dateNum(date) == dateNum(day)) == -1) {
          expect(false, DatabaseDao.filterTask(task1, day));
        } else {
          expect(true, DatabaseDao.filterTask(task1, day));
        }
      }
      final task2 = TaskData(
        tags: "",
        finishDay: "",
        finished: false,
        customRepeat: true,
        notes: "",
        id: 1,
        creationTime: datetimeToString(DateTime.now()),
        name: "task1",
        startingDay: datetimeToString(DateTime(2024, 1, 30)),
        flexibleTime: true,
        repeatType: 2,
        active: true,
        checkDays: "",
        lastModified: datetimeToString(DateTime.now()),
        weekly: "3#1101001",
      );
      //termina 24/05 sexta
      for (int daysToAdd = 0; daysToAdd <= 115; daysToAdd++) {
        var datesMyInterpretation = [
          DateTime(2024, 01, 30),
          DateTime(2024, 02, 01),
          DateTime(2024, 02, 04),
          DateTime(2024, 02, 05),

          DateTime(2024, 02, 20),
          DateTime(2024, 02, 22),
          DateTime(2024, 02, 25),
          DateTime(2024, 02, 26),

          DateTime(2024, 03, 12),
          DateTime(2024, 03, 14),
          DateTime(2024, 03, 17),
          DateTime(2024, 03, 18),

          DateTime(2024, 04, 02),
          DateTime(2024, 04, 04),
          DateTime(2024, 04, 07),
          DateTime(2024, 04, 08),

          DateTime(2024, 04, 23),
          DateTime(2024, 04, 25),
          DateTime(2024, 04, 28),
          DateTime(2024, 04, 29),

          DateTime(2024, 05, 14),
          DateTime(2024, 05, 16),
          DateTime(2024, 05, 19),
          DateTime(2024, 05, 20),
        ];
        var day = addDays(initialDate, daysToAdd);

        if (datesMyInterpretation.indexWhere(
              (date) => dateNum(date) == dateNum(day),
            ) ==
            -1) {
          try {
            expect(false, DatabaseDao.filterTask(task2, day));
          } catch (e) {
            debugPrint("dia errado:$day");
            expect(false, DatabaseDao.filterTask(task2, day));
          }
        } else {
          try {
            expect(true, DatabaseDao.filterTask(task2, day));
          } catch (e) {
            debugPrint("dia errado:$day");
            expect(true, DatabaseDao.filterTask(task2, day));
          }
        }
      }
      TaskData task3 = TaskData(
        tags: "",
        finishDay: "",
        finished: false,
        id: 3,
        creationTime: datetimeToString(DateTime.now()),
        name: "task3",
        startingDay: datetimeToString(DateTime(2024, 2, 1)),
        flexibleTime: true,
        notes: "",
        repeatType: 2,
        customRepeat: false,
        active: true,
        checkDays: "",
        lastModified: datetimeToString(DateTime.now()),
        weekly: "1#0000000",
      );
      for (int daysToAdd = 0; daysToAdd <= 115; daysToAdd++) {
        var correctDate = [
          DateTime(2024, 02, 01),
          DateTime(2024, 02, 08),
          DateTime(2024, 02, 15),
          DateTime(2024, 02, 22),
          DateTime(2024, 02, 29),

          DateTime(2024, 03, 7),
          DateTime(2024, 03, 14),
          DateTime(2024, 03, 21),
          DateTime(2024, 03, 28),

          DateTime(2024, 04, 04),
          DateTime(2024, 04, 11),
          DateTime(2024, 04, 18),
          DateTime(2024, 04, 25),

          DateTime(2024, 05, 2),
          DateTime(2024, 05, 9),
          DateTime(2024, 05, 16),
          DateTime(2024, 05, 23),
        ];
        var day = addDays(initialDate, daysToAdd);

        if (correctDate.indexWhere((date) => dateNum(date) == dateNum(day)) ==
            -1) {
          try {
            expect(false, DatabaseDao.filterTask(task3, day));
          } catch (e) {
            debugPrint("dia errado:$day");
            expect(false, DatabaseDao.filterTask(task3, day));
          }
        } else {
          try {
            expect(true, DatabaseDao.filterTask(task3, day));
          } catch (e) {
            debugPrint("dia errado:$day");
            expect(true, DatabaseDao.filterTask(task3, day));
          }
        }
      }
    });
  });
}*/
