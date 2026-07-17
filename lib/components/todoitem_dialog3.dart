import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/change_todoitem_dialog.dart';
import 'package:my_gtd_manager_2/components/error_dialog.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TodoItemDialog3 extends StatefulWidget {
  final int todoItemId;

  const TodoItemDialog3(this.todoItemId, {super.key});
  @override
  State<TodoItemDialog3> createState() => _TodoItemDialog3();
}

class _TodoItemDialog3 extends State<TodoItemDialog3> {
  late TodoElementData elementData;
  Future<TodoElementData> getData() async {
    return await DatabaseDao.getTodoItem(widget.todoItemId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AlertDialog(content: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return errorDialog(context);
        } else {
          elementData = snapshot.data!;
          return TodoItemDialog(
            listId: elementData.listParent,
            itemData: elementData,
          );
        }
      },
    );
  }
}
