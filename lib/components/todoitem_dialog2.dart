import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/error_dialog.dart';
import 'package:my_gtd_manager_2/components/new_todoitem_dialog.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TodoItemDialog2 extends StatefulWidget {
  final int projectId;
  final String initialName;

  const TodoItemDialog2(this.projectId, this.initialName, {super.key});
  @override
  State<TodoItemDialog2> createState() => _TodoItemDialog();
}

class _TodoItemDialog extends State<TodoItemDialog2> {
  late List<MyListData> list;
  Future<List<MyListData>> getData() async {
    return await DatabaseDao.getAllTodoLists();
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
          list = snapshot.data!;
          return NewTodoItemDialog(widget.projectId, list, widget.initialName);
        }
      },
    );
  }
}
