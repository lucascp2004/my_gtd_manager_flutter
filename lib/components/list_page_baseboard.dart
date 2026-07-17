import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/baseboard.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class ListPageBaseBoard extends StatelessWidget {
  final int listId;
  final Future<void> Function()? buttonfunction;

  const ListPageBaseBoard(this.listId, {this.buttonfunction, super.key});
  Future<void> onClick(bool value) async {
    return DatabaseDao.changeShowAll(value, listId);
  }

  @override
  Widget build(BuildContext context) {
    return BaseBoard(
      DatabaseDao.showAllStream(listId),
      onClick,
      buttonfunction: buttonfunction,
    );
  }
}
