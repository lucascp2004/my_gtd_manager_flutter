import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/custom_check_button.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TodoItemCheckbox extends StatelessWidget {
  final bool value;
  final int itemId;
  final int index;
  final int? projectId;
  const TodoItemCheckbox(
    this.value,
    this.itemId,
    this.index, {
    this.projectId,
    super.key,
  });

  Future<void> setValue(bool newValue) async {
    await DatabaseDao.changetodoItemIsChecked(
      newValue,
      itemId,
      projectId: projectId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCheckButton(value, setValue, "$index cb");
  }
}
