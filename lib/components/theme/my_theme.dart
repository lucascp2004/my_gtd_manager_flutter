import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
  appBarTheme: AppBarTheme(
    titleTextStyle: ThemeText.appBarTheme,
    iconTheme: const IconThemeData(color: Colors.black),
    color: Colors.grey.shade300,
  ),
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: WidgetStateProperty.all(Colors.transparent),
  ),

  scaffoldBackgroundColor: Colors.white,
);
