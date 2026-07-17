import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/baseboard.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class PlannerBaseBoard extends StatelessWidget {
  const PlannerBaseBoard({super.key});
  Future<void> onClick(bool value) async {
    return DatabaseDao.changeSettingsShowAll(value);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBoard(DatabaseDao.showAllPlannerStream(), onClick);
  }
}
