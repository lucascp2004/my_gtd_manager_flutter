import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/dates_lines_v2.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/controllers/my_date.dart';

class PlannerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MyDate date;
  final void Function() changeDatePlanner;
  final BoolControler isLoading;
  final Widget leading;

  const PlannerAppBar({
    required this.leading,
    required this.date,
    required this.changeDatePlanner,
    required this.isLoading,
    super.key,
  });
  @override
  Size get preferredSize => const Size.fromHeight(240);
  @override
  Widget build(BuildContext pageContext) {
    return AppBar(
      leading: leading,
      title: Text(AppLocalizations.of(pageContext)!.planner),

      bottom: OldDatesLines(date, changeDatePlanner, isLoading),
    );
  }
}
