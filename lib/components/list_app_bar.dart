import 'package:flutter/material.dart';

import 'package:my_gtd_manager_2/components/name_list_text.dart';
import 'package:my_gtd_manager_2/components/page_options.dart';
import 'package:my_gtd_manager_2/components/todo_insert_element.dart';
import 'package:my_gtd_manager_2/helpers.dart';

import 'rounded_insert_element.dart';

class ListAppBr extends StatelessWidget implements PreferredSizeWidget {
  final int listID;
  final PageOptions option;
  const ListAppBr(this.listID, this.option, {super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.menu),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: ListTile(
                  title: const Text('Youtube tutorial'),
                  onTap: () async {
                    await mylaunchURL(context);
                  },
                ),
              ),
            ];
          },
        ),
      ],
      title: NameListText(listID, option),
      bottom: (option == PageOptions.todoListPage)
          ? TodoInsertElement(listID) as PreferredSizeWidget
          : RoundedInsertElement(listID),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight((option == PageOptions.todoListPage) ? 120 : 166);
}
