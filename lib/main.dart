import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_gtd_manager_2/router.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

import 'firebase_options.dart';
//import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz1;

Future<void> _configureLocalTimeZone() async {
  tz1.initializeTimeZones();
  TimezoneInfo localTimeZone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(localTimeZone.identifier));
}

void main() async {
  debugPrint("iniciar widgets");
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("configurar timezone");
  await _configureLocalTimeZone();
  debugPrint("iniciar preferencias");
  //await NativeCode.initializePreferences();
  debugPrint("iniciaizar firebase");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: myTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}


/*class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppLocalizations.of(context)!.appName,
      theme: myTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: router,
      
    );
  }
}*/

