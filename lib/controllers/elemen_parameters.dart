import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ElementParameters {
  final ElementBase data;
  final int deepth;
  ElementParameters(this.data, this.deepth);
  int get id => data.id;
  String get name => data.name;
  bool get hasListParent => data.hasListParent;
  String get position => data.position;
  int get parentId => data.getParentId();

  bool get isItem => (data is MyElementData) || (data is TodoElement);
}
