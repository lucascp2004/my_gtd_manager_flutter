import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const RoundedButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      child: TextButton(
        onPressed: onPressed,
        child: Text(text, style: ThemeText.black16Size),
      ),
    );
  }
}
