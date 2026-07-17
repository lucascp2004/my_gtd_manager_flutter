import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class SaveButton extends StatelessWidget {
  final void Function() onPressed;
  const SaveButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      child: TextButton(
        key: const Key("SaveButton1"),
        onPressed: () {
          onPressed();
        },
        child: Text(
          AppLocalizations.of(context)!.save,
          style: ThemeText.black16Size,
        ),
      ),
    );
  }
}
