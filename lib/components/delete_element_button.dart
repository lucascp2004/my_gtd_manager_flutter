import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/controllers/bool_controller.dart';
import 'package:my_gtd_manager_2/database/database.dart';

enum ElementType { item, folder, task, todoItem }

// ignore: must_be_immutable
class DeleteElementButton extends StatelessWidget {
  final int id;
  final bool hasRelatedItems;
  final int? projectIdRelated;

  final ElementType type;

  const DeleteElementButton({
    required this.type,
    required this.id,

    required this.hasRelatedItems,
    this.projectIdRelated,

    super.key,
  });
  Future<bool> deleteData() {
    return DatabaseDao.getDeleteData();
  }

  Future<bool> showSecondDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return secondDialog(context);
      },
    );

    return confirmDelete == true;
  }

  AlertDialog secondDialog(BuildContext context) {
    String confirmDeleteLabel, elementStr;
    if (type == ElementType.task) {
      elementStr = AppLocalizations.of(context)!.task;
      confirmDeleteLabel = AppLocalizations.of(
        context,
      )!.deleteConfirmation(elementStr, "esta");
    } else if (type == ElementType.folder) {
      elementStr = AppLocalizations.of(context)!.folder;
      confirmDeleteLabel = AppLocalizations.of(
        context,
      )!.deleteConfirmation(elementStr, "esta");
    } else {
      elementStr = AppLocalizations.of(context)!.item;
      confirmDeleteLabel = AppLocalizations.of(
        context,
      )!.deleteConfirmation(elementStr, "este");
    }
    return AlertDialog(
      content: Text(confirmDeleteLabel),
      actions: <Widget>[
        const CancelButton(key: Key("CancelButton2")),
        ContainerWithBorder(
          child: TextButton(
            child: Text(
              key: const Key("finalDelete"),
              AppLocalizations.of(context)!.del,
              style: ThemeText.deleteButton,
            ),
            onPressed: () {
              // Close the confirm dialog with true
              Navigator.of(context).pop(true);
            },
          ),
        ),
      ],
    );
  }

  void action(BuildContext context) {
    if (type == ElementType.item) {
      DatabaseDao.deleteItem(id: id).then((_) {
        if (context.mounted) Navigator.pop(context);
      });
      return;
    } else if (type == ElementType.folder) {
      DatabaseDao.deleteSublist(id).then((_) {
        if (context.mounted) Navigator.pop(context);
      });
    } else if (type == ElementType.task) {
      DatabaseDao.deleteTask(taskId: id).then((value) {
        if (context.mounted) Navigator.pop(context);
      });
    } else {
      DatabaseDao.deleteTodoItem(id: id).then((_) {
        if (context.mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String deleteLabel;
    if (type == ElementType.folder) {
      deleteLabel = AppLocalizations.of(context)!.deleteFolder;
    } else if (type == ElementType.task) {
      deleteLabel = AppLocalizations.of(context)!.deleteTask;
    } else {
      deleteLabel = AppLocalizations.of(context)!.deleteItem;
    }
    return ContainerWithBorder(
      child: TextButton(
        key: const Key("deleteButton"),
        onPressed: () async {
          showSecondDialog(context).then((result) {
            if (result) {
              if (context.mounted) action(context);
            }
          });
        },
        child: Text(deleteLabel, style: ThemeText.deleteButton),
      ),
    );
  }
}
