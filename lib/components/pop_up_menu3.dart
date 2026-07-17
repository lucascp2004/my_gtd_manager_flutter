import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/components/todoitem_dialog3.dart';

class PopUpMenu3 extends StatelessWidget {
  const PopUpMenu3({super.key, required this.child, required this.id});

  final Widget child;
  final int id;

  @override
  Widget build(BuildContext context) {
    String labelTask = AppLocalizations.of(context)!.seeRelatedTodoItem;

    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          child: TextButton(
            key: const Key("seeRelatedTodoItem"),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return TodoItemDialog3(id);
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
