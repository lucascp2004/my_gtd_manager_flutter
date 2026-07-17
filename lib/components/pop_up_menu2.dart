import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/task_form2.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class PopUpMenu2 extends StatelessWidget {
  const PopUpMenu2({super.key, required this.id, required this.child});

  final int id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    String labelTask = AppLocalizations.of(context)!.seeRelatedTask;

    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: TextButton(
            key: const Key("seeRelatedTask"),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return TaskForm2(id);
                },
              ).then((value) {
                if (context.mounted) Navigator.pop(context);
              });
            },
            child: Text(labelTask, style: ThemeText.popUpMenuLabel),
          ),
        ),
      ],
      child: child,
    );
  }
}
