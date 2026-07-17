import 'package:my_gtd_manager_2/components/home_tile.dart';

import '../math.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ListsView extends StatelessWidget {
  final List<MyListData> list;

  const ListsView(this.list, {super.key});

  Future<void> reorder(int oldIndex, int newIndex) async {
    var newIndexPos = list[newIndex].position;
    String oldIndexPos;
    if (newIndex == 0) {
      /* Mude isso de acordo com o banco de dados */

      oldIndexPos = increaseNumber(newIndexPos);
    } else if (newIndex == list.length - 1) {
      oldIndexPos = divideByTwo(newIndexPos);
    } else {
      var thirdListIndex = (newIndex < oldIndex)
          ? (newIndex - 1)
          : (newIndex + 1);
      //var thirdListId = list[thirdListIndex].id;
      var thirdListPos = list[thirdListIndex].position;
      oldIndexPos = avarage(newIndexPos, thirdListPos);
    }
    await DatabaseDao.setListPosition(oldIndexPos, list[oldIndex].id);
  }

  void printList() {
    debugPrint("Print Visual List");
    for (var l in list) {
      debugPrint(l.name);
    }
    debugPrint("Fim Print Visual List");
  }

  @override
  Widget build(BuildContext context) {
    var todoList = (list.isEmpty) ? false : list[0].todoList;
    printList();
    return ReorderableListView.builder(
      key: const Key("dragging List"),
      onReorder: (oldIndex, newIndex) async {
        if (newIndex > oldIndex) newIndex--;
        if (oldIndex == newIndex) return;
        await reorder(oldIndex, newIndex);
      },
      itemCount: list.length,
      itemBuilder: (context, index) {
        return HomeTile(
          todoList: todoList,
          index: index,
          key: Key("$index home"),
          isDragging: false,
          listId: list[index].id,
          text: list[index].name,
        );
      },
    );
  }
}
