import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/dropdraw.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/components/save_button.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

// ignore: must_be_immutable
class NewTodoItemDialog extends StatefulWidget {
  final int projectId;
  final String initialName;
  List<MyListData> list;
  NewTodoItemDialog(this.projectId, this.list, this.initialName, {super.key});

  @override
  State<NewTodoItemDialog> createState() => _NewTodoItemDialogState();
}

class _NewTodoItemDialogState extends State<NewTodoItemDialog> {
  IntController listIdController = IntController();
  var nameInput = TextEditingController();
  var notesInput = TextEditingController();
  @override
  void initState() {
    if (widget.list.isNotEmpty) {
      widget.list = DatabaseDao.myListsOrderded(widget.list);
      listIdController.value = widget.list[0].id;
    }
    nameInput.text = widget.initialName;
    super.initState();
  }

  void onPressed() async {
    var text = nameInput.text.trim();
    var notes = notesInput.text.trim();
    var listId = listIdController.value;
    if (nameInput.text.trim().isEmpty) return;

    DatabaseDao.addTodoItem(
      text,
      listId,
      notes,
      projectId: widget.projectId,
    ).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> dropdownValues = {};
    for (var v in widget.list) {
      String name;
      /*if(v.id==1){
        name=AppLocalizations.of(context)!.todoList1;
      } else if (v.id==2){
        name=AppLocalizations.of(context)!.todoList2;
      } else if (v.id==3){
        name=AppLocalizations.of(context)!.todoList3;
      } else{

        name=v.name;
      }*/
      name = v.name;
      dropdownValues[name] = v.id;
    }

    if (widget.list.isEmpty) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(AppLocalizations.of(context)!.noTodoListError),
        actions: [
          TextButton(
            child: Text('Ok', style: ThemeText.black16Size),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    } else {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.newItem),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyDropdown(dropdownValues, listIdController),
            const SizedBox(height: 8),
            TextField(
              onSubmitted: (value) async {
                onPressed();
              },
              key: const Key("nameInput"),
              controller: nameInput,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: AppLocalizations.of(context)!.insertTodoItem,
                hintStyle: ThemeText.hintStyle2,
              ),
            ),
            const SizedBox(height: 8),
            NotesWidget(notesInput: notesInput),
          ],
        ),
        actions: [
          const CancelButton(),
          SaveButton(onPressed: onPressed),
        ],
      );
    }
  }
}
