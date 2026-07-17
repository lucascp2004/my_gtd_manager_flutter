import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/custom_textformfield.dart';
import 'package:my_gtd_manager_2/components/delete_element_button.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/components/save_button.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/validators.dart';

import 'cancel_button.dart';

class TodoItemController {
  int? todoItemid;
  int? relatedElementId;
  TextEditingController nameInput = TextEditingController();
  TextEditingController notesInput = TextEditingController();

  TodoItemController(TodoElementData? itemData) {
    if (itemData != null) {
      notesInput.text = itemData.notes;
      nameInput.text = itemData.name;
      todoItemid = itemData.id;
      relatedElementId = itemData.relatedElementId;
    }
  }
  String getNotes() => notesInput.text.trim();
  String getText() => nameInput.text.trim();
}

class TodoItemDialog extends StatefulWidget {
  final int listId;

  final TodoElementData? itemData;

  const TodoItemDialog({this.itemData, required this.listId, super.key});

  @override
  State<TodoItemDialog> createState() => _TodoItemDialogState();
}

class _TodoItemDialogState extends State<TodoItemDialog> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  late TodoItemController controller;
  late bool isNew;
  @override
  void initState() {
    isNew = widget.itemData == null;
    controller = TodoItemController(widget.itemData);
    super.initState();
  }

  onpress() async {
    if (formkey.currentState!.validate()) {
      if (isNew) {
        DatabaseDao.addTodoItem(
          controller.getText(),
          widget.listId,
          controller.getNotes(),
        ).then((_) {
          if (mounted) Navigator.pop(context);
        });
      } else {
        DatabaseDao.changeTodoItem(
          controller.getText(),
          controller.getNotes(),
          controller.todoItemid!,
        ).then((_) {
          if (mounted) Navigator.pop(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = (isNew)
        ? AppLocalizations.of(context)!.newItem
        : AppLocalizations.of(context)!.changeItem;
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              key: const Key("todoitemInput"),
              onSubmitted: (value) {
                onpress();
              },
              validator: Validator.notEmpty(context),
              input: controller.nameInput,
              hint: AppLocalizations.of(context)!.itemName,
            ),
            const SizedBox(height: 15),
            NotesWidget(notesInput: controller.notesInput),
            (isNew)
                ? Container()
                : DeleteElementButton(
                    id: controller.todoItemid!,
                    type: ElementType.todoItem,
                    hasRelatedItems: controller.relatedElementId != null,
                    projectIdRelated: controller.relatedElementId,
                  ),
          ],
        ),
      ),
      actions: [
        const CancelButton(),
        SaveButton(onPressed: onpress),
      ],
    );
  }
}
