
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart' as j;

@j.JsonSerializable()
class RelatedItem{
  int itemId;
  bool isChecked;
  RelatedItem(this.itemId,this.isChecked);
  Map<String,dynamic> toJson() => {
    'itemId':itemId,
    'isChecked': isChecked,
  };
  factory RelatedItem.fromJson(Map<String,dynamic> json) => RelatedItem(
    json['itemId'],
    json['isChecked'],
  );

}
@j.JsonSerializable()
class RelatedTask{
  int taskId;
  bool isChecked;
  RelatedTask(this.taskId,this.isChecked);
  Map<String,dynamic> toJson() => {
    'taskId':taskId,
    'isChecked': isChecked,
  };
  factory RelatedTask.fromJson(Map<String,dynamic> json) => RelatedTask(
    json['taskId'],
    json['isChecked'],
  );

}
class RelatedItemConverter extends TypeConverter<List<RelatedItem>,String> {
  const RelatedItemConverter();
  @override
  List<RelatedItem> fromSql(String fromDb){
    
    if (fromDb==""){
      return [];
    }
  
    List<dynamic> jsonList = jsonDecode(fromDb);
    return jsonList.map((jsonItem) => RelatedItem.fromJson(jsonItem)).toList();

  }
  @override
  String toSql(List<RelatedItem> value) {
    return jsonEncode(value.map((item) => item.toJson()).toList());
  }
}
class RelatedTaskConverter extends TypeConverter<List<RelatedTask>,String> {
  const RelatedTaskConverter();
  @override
  List<RelatedTask> fromSql(String fromDb){
    if (fromDb==""){
      return [];
    }
  
    List<dynamic> jsonList = jsonDecode(fromDb);
    return jsonList.map((jsonItem) => RelatedTask.fromJson(jsonItem)).toList();

  }
  @override
  String toSql(List<RelatedTask> value) {
    return jsonEncode(value.map((item) => item.toJson()).toList());
  }
}

typedef FromString<T> = T Function(String);

class MyType {


  MyType();

  
  MyType fromString(String s) {
    return MyType();
  }
}

class TaskOrItem extends MyType{
  int id;

  bool checked;
  bool isTask;

  TaskOrItem({required this.id,required this.checked,required this.isTask});
  @override
  TaskOrItem.fromString(String value):
    id = int.parse(value.split("-")[0]),
    checked = int.parse(value.split("-")[1])==1,    
    isTask = int.parse(value.split("-")[2])==1;
  @override
  String toString() {
    var checkedStr = (checked)?'1':'0';
    var isTaskStr = (isTask)?'1':'0';
    return '$id-$checkedStr-$isTaskStr';    
  }
}

List<TaskOrItem> stringToList(String value){
  
  if (value=="") return [];
  return value.split("#").map((item) => TaskOrItem.fromString(item)).toList();
}

/*List<T> stringToList<T extends MyType>(String value,FromString<T> fromString){
  
  if (value=="") return [];
  return value.split("#").map((item) => fromString(item)).toList();
}*/
String listToString(List<TaskOrItem> list){
  if (list.isEmpty) return "";
  return list.map((e) => e.toString()).join('#');
}
/*String listToString<T>(List<T> list){
  if (list.isEmpty) return "";
  return list.map((e) => e.toString()).join('#');
}*/
List<RelatedItem> uncheckItemInList(List<RelatedItem> list, int id){
  var item = list.firstWhere((element) => element.itemId==id);
  item.isChecked=false;
  return list;
}
List<RelatedItem> checkItemInList(List<RelatedItem> list,int id ){
  var item = list.firstWhere((element) => element.itemId==id);
  item.isChecked=true;
  return list;
}
List<TaskOrItem> checkTaskInList(List<TaskOrItem> list, int id){
  var item = list.firstWhere((element) => element.id==id && element.isTask) ;
  item.checked=true;
  return list;
}
List<TaskOrItem> uncheckTaskInList(List<TaskOrItem> list, int id){
  var item = list.firstWhere((element) => element.id==id && element.isTask) ;
  item.checked=false;
  return list;
}
List<TaskOrItem> addItemInList(List<TaskOrItem> list,int id){
  list.add(TaskOrItem(id: id,checked:  false,isTask: false));
  return list;
}
List<TaskOrItem> addTaskInList(List<TaskOrItem> list,int id){
  list.add(TaskOrItem(id: id,checked:  false,isTask: true));
  return list;
}
List<RelatedItem> removeItemInList(List<RelatedItem> list,int id){
  list.removeWhere((item)=>item.itemId==id);
  return list;
}
List<TaskOrItem> removeTaskInList(List<TaskOrItem> list,int id){
  list.removeWhere((item)=>item.isTask && item.id==id);
  return list;
}