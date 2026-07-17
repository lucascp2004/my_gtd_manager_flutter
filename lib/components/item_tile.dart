import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/change_element_dialog.dart';
import 'package:my_gtd_manager_2/components/change_todoitem_dialog.dart';
import 'package:my_gtd_manager_2/components/check_icon.dart';
import 'package:my_gtd_manager_2/components/item_check_box.dart';
import 'package:my_gtd_manager_2/components/notes_icon.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/pop_up_icon.dart';
import 'package:my_gtd_manager_2/components/pop_up_menu1.dart';
import 'package:my_gtd_manager_2/components/pop_up_menu2.dart';
import 'package:my_gtd_manager_2/components/pop_up_menu3.dart';
import 'package:my_gtd_manager_2/components/text_tile.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/components/todoitem_checkbox.dart';
import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/database/database.dart';

import 'custom_list_tile.dart';
import 'theme/theme_colors.dart';

class ItemTile extends StatefulWidget {
  final PageOptions option;
  final int index;
  final bool isDragging;
  final ElementBase itemData;
  final int deepth;

  const ItemTile({
    super.key,
    required this.option,
    required this.index,
    required this.isDragging,
    required this.itemData,
    required this.deepth,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  late bool isChecked;
  @override
  initState() {
    isChecked = getIsChecked();
    super.initState();
  }

  void tileOnTap() async {
    await showDialog(
      context: context,
      builder: (context) => (widget.option == PageOptions.todoListPage)
          ? TodoItemDialog(
              listId: widget.itemData.getParentId(),
              itemData: widget.itemData as TodoElementData,
            )
          : ChangeElementDialog(elementData: widget.itemData),
    );
  }

  Widget popUp(Widget child) {
    var elementData = widget.itemData as MyElementData;
    if (!elementData.hasRelatedItem()) {
      return PopUpMenu1(
        id: widget.itemData.id,
        initialName: widget.itemData.name,
        child: child,
      );
    } else if (elementData.todoitemIdRelated != null) {
      return PopUpMenu3(id: elementData.todoitemIdRelated!, child: child);
    } else {
      return PopUpMenu2(id: elementData.taskIdRelated!, child: child);
    }
  }

  Widget? trailing() {
    var notes = widget.itemData.notes.trim();
    var hasNotes = (notes != '');

    if (widget.option == PageOptions.todoListPage) {
      return (hasNotes)
          ? NotesIcon(key: Key("notesIcon ${widget.index}"))
          : null;
    } else {
      bool onlyOneWidget = true;
      List<Widget> children = [];
      if (hasNotes) {
        onlyOneWidget = false;
        children.add(NotesIcon(key: Key("notesIcon ${widget.index}")));
      }
      if (widget.itemData.hasRelatedItem()) {
        onlyOneWidget = false;
        children.add(CheckIcon(key: Key("ckIcon ${widget.index}")));
      }

      children.add(
        PopUpIcon(onlyOneWidget, key: Key("PopUpIcon ${widget.index}")),
      );
      var child = Padding(
        padding: EdgeInsets.only(
          right: 6.0,
          left: (onlyOneWidget) ? 28 : 6,
          top: 11,
          bottom: 11,
        ),

        child: Row(children: children),
      );
      return popUp(child);
    }
  }

  bool getIsChecked() {
    if (widget.itemData is MyElementData) {
      return (widget.itemData as MyElementData).isChecked;
    }
    return (widget.itemData as TodoElementData).isChecked;
  }

  @override
  Widget build(BuildContext context) {
    var color = (isChecked) ? MyColors.itemTileChecked : MyColors.itemTile;
    //debugPrint("COLOR:$color");

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: (widget.isDragging)
            ? Border.all(color: Colors.blue, width: 1)
            : Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(left: widget.deepth * 20, top: 4),

      child: CustomListTile(
        title: TextTile(widget.itemData.name, textStyle: ThemeText.black16Size),

        height: 50,
        trailing: trailing(),

        isChecked: isChecked,
        onTap: tileOnTap,
        key: Key(widget.index.toString()),
        leading: (widget.option == PageOptions.todoListPage)
            ? TodoItemCheckbox(
                isChecked,
                widget.itemData.id,
                widget.index,
                projectId:
                    (widget.itemData as TodoElementData).relatedElementId,
              )
            : ItemCheckButton(
                isChecked,
                widget.itemData.id,
                widget.index,
                (widget.itemData as MyElementData).taskIdRelated,
                (widget.itemData as MyElementData).todoitemIdRelated,
              ),
      ),
    );
  }
}
