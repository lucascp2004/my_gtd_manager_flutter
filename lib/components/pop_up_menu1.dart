import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/task_form.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/components/todoitem_dialog2.dart';

class PopUpMenu1 extends StatelessWidget {
  const PopUpMenu1({
    super.key,
    required this.child,
    required this.id,
    required this.initialName,
  });

  final Widget child;
  final int id;
  final String initialName;

  @override
  Widget build(BuildContext context) {
    String labelTask = AppLocalizations.of(context)!.relatedTask;
    String labelList = AppLocalizations.of(context)!.relatedList;
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: TextButton(
            key: const Key("InsertTask2"),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return TaskForm(
                    initialName: initialName,
                    startingDay: DateTime.now(),
                    projectIdRelated: id,
                  );
                },
              ).then((value) {
                if (context.mounted) Navigator.pop(context);
              });
            },
            child: Text(labelTask, style: ThemeText.popUpMenuLabel),
          ),
        ),
        PopupMenuItem<String>(
          child: TextButton(
            key: const Key("InsertTodoItem2"),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return TodoItemDialog2(id, initialName);
                },
              ).then((value) {
                if (context.mounted) Navigator.pop(context);
              });
            },
            child: Text(labelList, style: ThemeText.popUpMenuLabel),
          ),
        ),
      ],
      child: child,
    );
  }
}
