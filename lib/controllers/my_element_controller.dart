import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';

class ElementController {
  final TextEditingController name;
  final TextEditingController notes;
  final bool isItem;
  final int id;
  final int listId;
  final int sublistId;
  IntController listIdController;
  IntController sublistIdController;
  ElementController({
    required this.id,
    required this.listId,
    required this.sublistId,
    required this.isItem,
    required String name,
    required String notes,
  }) : listIdController = IntController(initialValue: listId),
       sublistIdController = IntController(initialValue: sublistId),
       name = TextEditingController(text: name),
       notes = TextEditingController(text: notes);
  String getName() {
    return name.text.trim();
  }

  String getNotes() {
    return name.text.trim();
  }
}
