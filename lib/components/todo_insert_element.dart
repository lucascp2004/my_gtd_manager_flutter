import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/rounded_container.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/database/database.dart';

// ignore: must_be_immutable
class TodoInsertElement extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  TextEditingController controller = TextEditingController();

  final int listId;

  TodoInsertElement(this.listId, {super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;

    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        color: color,
        child: RoundedContainer(
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),

            child: TextField(
              key: const Key("inputList"),
              controller: controller,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.insertTodoItem,
                hintStyle: ThemeText.hintStyle2,
              ),

              onSubmitted: (value) async {
                if (value.trim() != '') {
                  DatabaseDao.addTodoItem(value, listId, "");
                  controller.text = '';
                }
              },
            ),
          ),
          border: Border.all(width: 1, color: Colors.black),

          Colors.white,
        ),
      ),
    );
  }
}
