import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/name_delete_dialog.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

import '../database/database.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    required this.option,
    required this.listName,
    required this.listId,
    super.key,
  });
  final PageOptions option;
  final String listName;
  final int listId;
  Future<void> getNewName(String newName) async {
    if (newName != listName) {
      await DatabaseDao.changeListName(newName, listId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        listName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: ThemeText.appBarTheme,
      ),
      onPressed: () async {
        await showDialog<String?>(
          context: context,
          builder: (context) {
            return NameDeleteDialog(
              isProject: option == PageOptions.project,
              isNew: false,
              setName: getNewName,
              oldName: listName,
            );
          },
        );
      },
    );
  }
}
