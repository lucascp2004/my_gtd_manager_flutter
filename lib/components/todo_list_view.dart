import 'package:my_gtd_manager_2/components/item_tile.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import '../math.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/database/database.dart';

List<TodoElementData> filterList(List<TodoElementData> list, bool showAll) {
  if (showAll) {
    return list;
  } else {
    return list.where((e) => e.isChecked == false).toList();
  }
}

// ignore: must_be_immutable
class TodoListView extends StatelessWidget {
  final List<TodoElementData> realList;
  final bool showAll;
  late List<TodoElementData> visualList;

  TodoListView({required this.realList, required this.showAll, super.key});

  int getReaLIndex(int index) {
    if (showAll) return index;
    var id = visualList[index].id;
    return realList.indexWhere((element) => element.id == id);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    var isUp = newIndex < oldIndex;

    String oldIndexPos;
    if (newIndex == 0) {
      oldIndexPos = increaseNumber(realList[0].position);
    } else if (newIndex == visualList.length - 1) {
      oldIndexPos = divideByTwo(realList[realList.length - 1].position);
    } else {
      String firstElementPosition, secondElementPosition;
      if (isUp) {
        firstElementPosition = visualList[newIndex - 1].position;
        var firstElementRealListIndex = getReaLIndex(newIndex - 1);
        secondElementPosition =
            realList[firstElementRealListIndex + 1].position;
      } else {
        firstElementPosition = visualList[newIndex + 1].position;
        var firstElementRealListIndex = getReaLIndex(newIndex + 1);
        secondElementPosition =
            realList[firstElementRealListIndex - 1].position;
      }
      oldIndexPos = avarage(firstElementPosition, secondElementPosition);
    }
    await DatabaseDao.changeTodoItemOrder(visualList[oldIndex].id, oldIndexPos);
  }

  void printList() {
    debugPrint("Print Visual Todo List");
    for (var l in visualList) {
      debugPrint("${l.name} ${l.relatedElementId}");
    }
    debugPrint("Fim Print Visual List");
  }

  @override
  Widget build(BuildContext context) {
    visualList = filterList(realList, showAll);
    printList();
    return ReorderableListView.builder(
      key: const Key("dragging List"),
      onReorder: (oldIndex, newIndex) async {
        if (newIndex > oldIndex) newIndex--;
        if (oldIndex == newIndex) return;
        await reorder(oldIndex, newIndex);
      },
      itemCount: visualList.length,
      itemBuilder: (context, index) {
        var ck = visualList[index].isChecked ? ' ck' : '';
        return ItemTile(
          option: PageOptions.todoListPage,
          deepth: 0,
          itemData: visualList[index],
          index: index,
          key: Key("${visualList[index].name} $index$ck"),
          isDragging: false,
        );
      },
    );
  }
}
