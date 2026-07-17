import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gtd_manager_2/components/text_tile.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'box_decoration.dart';
import 'custom_list_tile.dart';
import 'name_delete_dialog.dart';
import 'rounded_container.dart';
import 'theme/theme_colors.dart';

// ignore: must_be_immutable
class HomeTile extends StatefulWidget {
  final int listId;
  String text;
  final int index;
  bool isDragging;
  final bool todoList;

  HomeTile({
    super.key,
    required this.todoList,
    required this.index,
    required this.text,
    required this.listId,
    required this.isDragging,
  });

  @override
  State<HomeTile> createState() => _HomeTileState();
}

class _HomeTileState extends State<HomeTile> {
  late Color color;

  goListPage() {
    if (widget.todoList) {
      GoRouter.of(context).go("/todolists/list/${widget.listId}");
    } else {
      GoRouter.of(context).go("/lists/list/${widget.listId}");
    }
  }

  setText(String text) {
    widget.text = text;
    setState(() {});
  }

  setToIsDragging() {
    widget.isDragging = true;
    setState(() {});
  }

  Future<void> deleteList(int id) async {
    await DatabaseDao.deleteList(id);
  }

  Future<void> getNewName(String newText) async {
    if (widget.text != newText) {
      await DatabaseDao.changeListName(newText, widget.listId);
    }
  }

  Future<void> newNameDialog() async {
    String name = widget.text;
    await showDialog<String?>(
      context: context,
      builder: (context) => NameDeleteDialog(
        isProject: !(widget.todoList),
        isNew: false,
        setName: getNewName,
        oldName: name,
        delete: () async {
          await deleteList(widget.listId);
        },
      ),
    );
  }

  String getText() {
    /*if (widget.listId==1) return AppLocalizations.of(context)!.todoList1; 
    if (widget.listId==2) return AppLocalizations.of(context)!.todoList2; 
    if (widget.listId==3) return AppLocalizations.of(context)!.todoList3; */
    return widget.text;
  }

  @override
  Widget build(BuildContext context) {
    color = MyColors.homeTile;
    var content = RoundedContainer(
      CustomListTile(
        title: TextTile(getText(), textStyle: ThemeText.black16Size),
        height: 50,
        onTap: goListPage,
        key: Key("${widget.text} ${widget.index}"),
        /* CustomHomeIcon(() async {
            iconFunction(widget.listId);
          }*/
        trailing: IconButton(
          key: Key("${widget.index} icon"),
          onPressed: () async {
            await newNameDialog();
          },
          icon: const Icon(Icons.more_vert),
        ),
      ),
      color,
    );
    return Container(
      decoration: getDecoration(widget.isDragging),
      margin: const EdgeInsets.only(top: 4),
      child: content,
    );
  }
}
