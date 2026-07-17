import 'package:flutter/material.dart';

import 'insert_element_dialog.dart';
import 'theme/theme_colors.dart';

class PlusButton extends StatefulWidget {
  final int listId;
  final int sublistId;

  const PlusButton(this.sublistId,this.listId, {super.key});

  @override
  State<PlusButton> createState() => _PlusButtonState();
}

class _PlusButtonState extends State<PlusButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
    
      iconSize: 30,
      color: MyColors.plusIconColor,
      onPressed: createNewElement,
      icon: const Icon(Icons.add_circle),
      padding: const EdgeInsets.all(9),
      constraints: const BoxConstraints(),
    );
  }

  void createNewElement() {
    showDialog(
        context: context,
        builder: (context) => InsertElementDialog(
          sublistId: widget.sublistId,
          ancestorId: widget.listId,
        ));
  }
}
