import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/change_element_dialog.dart';
import 'package:my_gtd_manager_2/components/custom_plus_buttom.dart';
import 'package:my_gtd_manager_2/components/custom_up_down_icon.dart';
import 'package:my_gtd_manager_2/components/text_tile.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'box_decoration.dart';
import 'custom_list_tile.dart';
import 'rounded_container.dart';
import 'theme/theme_colors.dart';

typedef ListChange = Future<String?> Function(int);

class SublistTile extends StatefulWidget {
  final MySublistData sublistData;
  final bool isDragging;
  final int index;
  final int isShrinked;

  final int deepth;
  const SublistTile({
    super.key,
    required this.sublistData,
    required this.isShrinked,
    required this.deepth,
    required this.isDragging,
    required this.index,
  });

  @override
  State<SublistTile> createState() => _SublistTileState();
}

class _SublistTileState extends State<SublistTile> {
  Color color = MyColors.sublistTile;

  Future<void> tileOnTap() async {
    await showDialog(
      context: context,
      builder: (context) {
        return ChangeElementDialog(elementData: widget.sublistData);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var content = RoundedContainer(
      CustomListTile(
        title: TextTile(
          widget.sublistData.name,
          textStyle: ThemeText.black16Size,
        ),
        height: 50,
        onTap: tileOnTap,
        key: Key(widget.index.toString()),
        leading: UpDownIcon(widget.isShrinked, widget.sublistData.id),
        trailing: PlusButton(
          widget.sublistData.id,
          widget.sublistData.ancestorId,
          key: Key("${widget.sublistData.id} +"),
        ),
      ),
      color,
    );
    return Container(
      decoration: getDecoration(widget.isDragging),
      margin: EdgeInsets.only(left: widget.deepth * 20, top: 4),
      child: content,
    );
  }
}
