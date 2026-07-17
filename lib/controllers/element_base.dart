abstract class ElementBase {

  int get id;
  String get name;
  bool get hasListParent;
  int? get listParent;
  int? get sublistParent;
  int get ancestorId;
  String get position;
  int getParentId();
  String get notes;
  bool hasRelatedItem();
}
