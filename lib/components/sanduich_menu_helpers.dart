import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/auth/auth_service.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/firebase/backup.dart';
import 'package:my_gtd_manager_2/helpers.dart';

import 'package:my_gtd_manager_2/router.dart' show router;

class MyDrawer extends StatelessWidget {
  final int position;
  const MyDrawer(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: items(context, position),
      ),
    );
  }

  void closeDrawer(BuildContext context) {
    Navigator.of(context).pop();
  }

  List<ListTile> items(BuildContext context, int position) {
    var todolistLabel = AppLocalizations.of(context)!.todolists;
    var projectsLabel = AppLocalizations.of(context)!.projects;
    var plannerLabel = AppLocalizations.of(context)!.planner;
    var logoutLabel = AppLocalizations.of(context)!.logout;
    var tutorialLabel = AppLocalizations.of(context)!.tutorial;

    var appBarTitles = [
      todolistLabel,
      projectsLabel,
      plannerLabel,

      tutorialLabel,
      logoutLabel,
    ];
    List<Function()> appBarFuncs = [
      () {
        Navigator.pop(context);
        router.go("/todolists");
      },
      () {
        Navigator.pop(context);
        router.go("/lists");
      },
      () {
        Navigator.pop(context);
        router.go("/planner");
      },
      () async {
        Navigator.pop(context);
        await mylaunchURL(context);
      },
      () async {
        Navigator.pop(context);
        await AuthService.signOut();
        DatabaseDao.setLogin(0).then((_) {
          Backup.cancelAll();

          router.go("/login");
        });
      },
    ];
    List<ListTile> result = [];
    result.add(ListTile(title: Text("GTD MANAGER")));
    for (var index = 0; index < appBarTitles.length; index++) {
      if (position == index) {
        result.add(
          ListTile(
            title: Text(
              key: Key("$index md"),
              appBarTitles[index],
              style: const TextStyle(color: Colors.black54),
            ),
            onTap: () {
              closeDrawer(context);
            },
          ),
        );
      } else {
        result.add(
          ListTile(
            key: Key("$index md"),
            title: Text(appBarTitles[index]),
            onTap: appBarFuncs[index],
          ),

          //onTap: appBarFuncs[index],
        );
      }
    }
    return result;
  }
}
