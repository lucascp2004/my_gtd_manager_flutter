import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/text_link.dart';

// ignore: must_be_immutable
class ReloadPage extends StatelessWidget {
  final PageOptions option;
  late String link;
  int? id;
  ReloadPage({super.key, required this.option, this.id}) {
    assert(
      (option != PageOptions.project && option != PageOptions.todoListPage) ||
          id != null,
      'if option is project or todoListPage id must no be null',
    );
    switch (option) {
      case PageOptions.projects:
        link = "/home";
        break;
      case PageOptions.todoListsPage:
        link = "/todolists";
        break;
      case PageOptions.planner:
        link = "/planner";
        break;
      case PageOptions.project:
        link = "/lists/list/$id";
        break;
      case PageOptions.todoListPage:
        link = "/todolists/list/$id";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: TextLink(AppLocalizations.of(context)!.reloadPage),
        onPressed: () {
          GoRouter.of(context).go(link);
        },
      ),
    );
  }
}
