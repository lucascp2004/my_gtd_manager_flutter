import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/custom_check_button.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ItemCheckButton extends StatelessWidget {
  final bool value;
  final int itemId;
  final int index;
  final int? taskIdRelated;
  final int? todoitemIdRelated;

  const ItemCheckButton(
    this.value,
    this.itemId,
    this.index,
    this.taskIdRelated,
    this.todoitemIdRelated, {
    super.key,
  });

  Future<void> setValue(bool newValue) async {
    await DatabaseDao.changeElementIsChecked2(
      newValue,
      itemId,
      taskIdRelated: taskIdRelated,
      todoitemIdRelated: todoitemIdRelated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCheckButton(value, setValue, "$index cb");
  }
}
