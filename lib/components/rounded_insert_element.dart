import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/rounded_container.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/database/database.dart';

import '../controllers/int_controller.dart';
import 'base_insert_element.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

// ignore: must_be_immutable
class RoundedInsertElement extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(106.0);
  final TextEditingController textInput = TextEditingController();
  final IntController optionController = IntController();
  final int listId;
  RoundedInsertElement(this.listId, {super.key});

  action(BuildContext context) {
    if (textInput.text.trim() != '') {
      DatabaseDao.addElement(
            ancestorId: listId,
            name: textInput.text,
            option: optionController.value,
            parentID: listId,
            notes: "",
            listIsParent: true,
          )
          .then((_) {
            textInput.text = "";
          })
          .catchError((error) {
            debugPrint(error.toString());
            if (context.mounted) {
              ShowMessages.messageSnackBar(
                AppLocalizations.of(context)!.localDataError,
                context,
              );
            }
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    Widget containerContent;

    containerContent = BaseInsertElement(
      onSubmitted: (value) {
        action(context);
      },
      optionController: optionController,
      textInput: textInput,
      isSublist: false,
      ancestorId: listId,
    );
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: RoundedContainer(
          containerContent,
          color,
          border: Border.all(width: 1, color: Colors.black),
        ),
      ),
    );
  }
}
