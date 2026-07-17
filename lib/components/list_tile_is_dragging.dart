/*import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ListTileIsDragging extends StatelessWidget {
  final int listId;
  const ListTileIsDragging(this.listId, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: DatabaseDao.isDraggingStream(listId),
        builder: (context, state) {
          if (state.hasError) {
            return const ListTile(
              title: Text("Local Database Error"),
            );
          }
          if (!state.hasData) {
            return const ListTile(
              title: Text("Loading..."),
            );
          }
          return ListTile(
            title: Text(AppLocalizations.of(context)!.dragItem),
            leading: Checkbox(
              value: state.data,
              onChanged: (value) {
                DatabaseDao.setIsdragging(listId, value!).then((_) {
                  Navigator.pop(context);
                });
              },
            ),
          );
        }
      );
  }
}*/
