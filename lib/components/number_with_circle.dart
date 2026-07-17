import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class NumberWithCicle extends StatelessWidget {
  const NumberWithCicle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(text, style: ThemeText.currentDay)),
    );
  }
}
