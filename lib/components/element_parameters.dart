/*import 'package:flutter/foundation.dart';
import 'package:my_gtd_manager_2/components/tile.dart';
import 'package:my_gtd_manager_2/controllers/list_int.dart';


class ElementParameters implements Tile {
  
  @override
  int deepth;
  @override
  bool hasListParent;
  @override
  int parentId;
  int id;
  String name;
  String position;
  String notes;
  
  List<TaskOrItem>? tasks;
  List<TaskOrItem>? todoItems;
  ElementParameters({
    
    required this.deepth,
    required this.name,
    
    required this.hasListParent,
    required this.id,
    
    required this.parentId,
    required this.position,
    required this.notes,
    this.tasks,
    this.todoItems,
  });
  bool hasRelatedItems(){
    debugPrint("hasRelatedItems function");
    if (tasks!=null){
      debugPrint("task not null");
      if (tasks!.isNotEmpty) return true;
    }
    if (todoItems!=null){
      debugPrint("todoItems not null");
      if (todoItems!.isNotEmpty) return true;
    }
    return false;
  }
}
*/
