import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/app_bar_title.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';

import '../database/database.dart';

class NameListText extends StatelessWidget {
  final int listId;
  final PageOptions option;
  const NameListText(this.listId, this.option, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: DatabaseDao.listNameStream(listId),
      builder: (context, state) {
        if (state.hasError) {
          return const Text("Local Database Error");
        }
        if (!state.hasData) {
          return const Text("Loading...");
        }
        return AppBarTitle(
          listName: state.data!,
          listId: listId,
          option: option,
        );
      },
    );
  }
}
