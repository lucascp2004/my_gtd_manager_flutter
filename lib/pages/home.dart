import 'package:my_gtd_manager_2/database/database.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/router.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Future<void> startingServices() async {
    var test = false;
    await DatabaseDao.openDb(test: test);
    var login = await DatabaseDao.getLogin();
    debugPrint("LOGIN: $login");
  }

  @override
  void initState() {
    super.initState();

    _initializeServicesAndCheckLogin();
  }

  Future<void> _initializeServicesAndCheckLogin() async {
    await startingServices();
    DatabaseDao.getLogin().then((login) {
      if (login == 0) {
        router.go("/login");
      } else {
        router.go("/lists");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
