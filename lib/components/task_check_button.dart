import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/function_provider.dart';
import 'show_messages.dart';

class TaskCheckButton extends StatelessWidget {
  final bool value;
  final int id;
  final String keyName;
  const TaskCheckButton(this.value, this.id, this.keyName, {super.key});

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
            FunctionProvider.of(context)!.sharedFunction(id, v).catchError((
              error,
            ) {
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
