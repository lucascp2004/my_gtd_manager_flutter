import 'package:my_gtd_manager_2/components/item_tile.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/sublist_tile.dart';

import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/elemen_parameters.dart';
import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/math.dart';

import '../database/database.dart';

// ignore: must_be_immutable
class MyListView extends StatefulWidget {
  final List<ElementParameters> rawList;

  final int listId;

  final bool showAll;
  final String listName;
  final MyListData listData;

  MyListView({required this.listData, required this.rawList, super.key})
    : showAll = listData.showAll,
      listName = listData.name,
      listId = listData.id;

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  late List<GlobalKey> keys;
  late List<ElementParameters> realList;
  int dragIndex = -1;

  int originalPos = -1;
  bool getIsChecked(ElementBase parameter) {
    if (parameter is MyElementData) {
      return parameter.isChecked;
    }
    return (parameter as TodoElementData).isChecked;
  }

  bool showElement(ElementBase parameter) {
    if (parameter is MySublistData) return true;

    if (widget.showAll) {
      return true;
    } else {
      return (!getIsChecked(parameter));
    }
  }

  void printVisualList() {
    debugPrint("dragging List");
    debugPrint("PRINT LIST\n");
    for (var e in realList) {
      var aux = ";" * e.deepth;

      debugPrint("$aux${e.data.name} ${e.data.position} ${e.data.id}");
    }

    debugPrint("\nFIM PRINT LIST");
  }

  List<ElementParameters> getElements(bool listParent, {int? sublistParent}) {
    List<ElementParameters> result;
    assert(
      (listParent && sublistParent == null) ||
          (!listParent && sublistParent != null),
    );
    if (listParent) {
      result = widget.rawList
          .where((element) => element.hasListParent)
          .toList();
      result.sort(((a, b) => myCompareTo(b.data.position, a.data.position)));
    } else {
      result = widget.rawList
          .where(
            (element) =>
                (!element.hasListParent && element.parentId == sublistParent),
          )
          .toList();
      result.sort(((a, b) => myCompareTo(b.position, a.position)));
    }
    return result;
  }

  void setPosition(ElementParameters element, String position) {
    DatabaseDao.changeElementOrder(
      element.id,
      element.hasListParent,
      element.parentId,
      position,
      element.isItem,
    );
  }

  Widget tile(ElementParameters parameter, Key key, int index) {
    if (parameter.isItem) {
      return ItemTile(
        option: PageOptions.project,
        index: index,
        key: key,
        itemData: parameter.data,
        isDragging: false,
        deepth: parameter.deepth,
      );
    } else {
      var sublist = parameter.data as MySublistData;
      return SublistTile(
        sublistData: sublist,
        index: index,
        key: key,
        isDragging: false,
        deepth: parameter.deepth,

        isShrinked: isShrinkedValue(sublist.isShrinked, sublist.id),
      );
    }
  }

  int isShrinkedValue(bool isShrinked, int id) {
    if (getElements(false, sublistParent: id).isEmpty) {
      return 2;
    }
    if (isShrinked) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    realList = filter1();

    printVisualList();
    return ListView.builder(
      key: const Key("dragging List"),
      physics: const AlwaysScrollableScrollPhysics(),
      //shrinkWrap: true,
      itemBuilder: ((context, index) {
        String keyStr;
        if (!realList[index].isItem) {
          keyStr = "${realList[index].name} $index";
        } else {
          keyStr = "${realList[index].name} $index";
          if ((realList[index].data as MyElementData).isChecked) {
            keyStr += " ck";
          }
        }
        return tile(realList[index], Key(keyStr), index);
      }),
      itemCount: realList.length,
    );
  }

  List<dynamic> addParameter(
    ElementParameters parameter,
    List<ElementParameters> result,
  ) {
    if (parameter.isItem) {
      if (showElement(parameter.data)) {
        result.add(parameter);
      }
      return [false, 0];
    } else {
      var sublist = parameter.data as MySublistData;
      result.add(parameter);
      if (sublist.isShrinked) {
        return [true, parameter.deepth];
      }
      return [false, 0];
    }
  }

  int getParentIndex(List<ElementParameters> list, int index, int deepth) {
    for (int i = index - 1; i >= 0; i--) {
      var tempElement = list[i];
      if (tempElement.deepth == (deepth - 1) &&
          tempElement.data is MySublistData) {
        return i;
      }
    }
    return -1;
  }

  List<ElementParameters> filter1() {
    List<ElementParameters> result = [];
    bool omit = false;
    int deepthOmit = 0;
    for (var parameter in widget.rawList) {
      if (!omit) {
        var functionResult = addParameter(parameter, result);
        omit = functionResult[0] as bool;
        deepthOmit = functionResult[1] as int;
      } else {
        if (parameter.deepth > deepthOmit) {
          continue;
        } else {
          var functionResult = addParameter(parameter, result);
          omit = functionResult[0] as bool;
          deepthOmit = functionResult[1] as int;
        }
      }
    }
    return result;
  }
}
