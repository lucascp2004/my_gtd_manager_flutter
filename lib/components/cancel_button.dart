import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/rounded_button.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      key: const Key("CancelButton1"),
      AppLocalizations.of(context)!.cancel,
      () {
        Navigator.pop(context);
      },
    );
  }
}
