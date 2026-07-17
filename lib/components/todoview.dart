import 'package:my_gtd_manager_2/components/item_tile.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';

import '../math.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class TodoView extends StatelessWidget {
  final List<TodoElementData> todoElements;

  const TodoView(this.todoElements, {super.key});

  Future<void> reorder(int oldIndex, int newIndex) async {
    var newIndexPos = await DatabaseDao.getTodoElementPosition(
      todoElements[newIndex].id,
    );
    String oldIndexPos;
    if (newIndex == 0) {
      /* Mude isso de acordo com o banco de dados */

      oldIndexPos = increaseNumber(newIndexPos);
    } else if (newIndex == todoElements.length - 1) {
      oldIndexPos = divideByTwo(newIndexPos);
    } else {
      var thirdListIndex = (newIndex < oldIndex)
          ? (newIndex - 1)
          : (newIndex + 1);
      var thirdListId = todoElements[thirdListIndex].id;
      var thirdListPos = await DatabaseDao.getTodoElementPosition(thirdListId);
      oldIndexPos = avarage(newIndexPos, thirdListPos);
    }
    await DatabaseDao.setListPosition(oldIndexPos, todoElements[oldIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: false,
      onReorder: (oldIndex, newIndex) async {
        if (newIndex > oldIndex) newIndex--;
        if (oldIndex == newIndex) return;
        await reorder(oldIndex, newIndex);
      },
      itemCount: todoElements.length,
      itemBuilder: (context, index) {
        return ItemTile(
          option: PageOptions.todoListPage,
          index: index,
          key: Key("$index home"),
          isDragging: false,

          itemData: todoElements[index],
          deepth: 0,
        );
      },
    );
  }
}
