import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class TextLabel extends StatelessWidget {
  final String text;
  const TextLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: ThemeText.appLabels);
  }
}
