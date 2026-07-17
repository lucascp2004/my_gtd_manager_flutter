import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

import 'show_messages.dart';

typedef CheckBoxFunction = Future<void> Function(bool);

class CustomCheckButton extends StatelessWidget {
  final bool value;
  final CheckBoxFunction setValue;
  final String keyName;
  const CustomCheckButton(this.value, this.setValue, this.keyName, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Checkbox(
        key: Key(keyName),
        shape: const CircleBorder(),
        activeColor: Colors.blue,

        value: value,
        onChanged: (v) async {
          if (v != null) {
            setValue(v).catchError((error) {
              if (context.mounted) {
                ShowMessages.messageSnackBar(
                  AppLocalizations.of(context)!.localDataError,
                  context,
                );
              }
            });
          }
        },
      ),
    );
  }
}
