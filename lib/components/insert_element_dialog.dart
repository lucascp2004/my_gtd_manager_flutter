import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/components/rounded_container.dart';
import 'package:my_gtd_manager_2/components/save_button.dart';
import 'package:my_gtd_manager_2/database/database.dart';

import '../controllers/int_controller.dart';
import 'base_insert_element.dart';
import 'show_messages.dart';

class InsertElementDialog extends StatefulWidget {
  final int? sublistId;
  final int ancestorId;

  const InsertElementDialog({
    this.sublistId,
    required this.ancestorId,
    super.key,
  });

  @override
  State<InsertElementDialog> createState() => _InsertElementDialogState();
}

class _InsertElementDialogState extends State<InsertElementDialog> {
  final TextEditingController textInput = TextEditingController();
  final TextEditingController notesInput = TextEditingController();
  final IntController optionController = IntController();

  //late RadioGroup radioGroup;
  late BaseInsertElement baseElement;
  action() async {
    if (textInput.text.trim() != '') {
      DatabaseDao.addElement(
            ancestorId: widget.ancestorId,
            name: textInput.text,
            option: optionController.value,
            parentID: (widget.sublistId == null)
                ? widget.ancestorId
                : widget.sublistId!,
            notes: notesInput.text,
            listIsParent: false,
          )
          .then((_) {
            if (mounted) Navigator.pop(context);
          })
          .catchError((error) {
            if (mounted) {
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

    baseElement = BaseInsertElement(
      optionController: optionController,
      textInput: textInput,
      onSubmitted: (String value) {
        action();
      },
      isSublist: true,
      ancestorId: widget.ancestorId,
    );

    Widget containerContent = RoundedContainer(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          baseElement,
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: NotesWidget(notesInput: notesInput),
          ),
        ],
      ),
      color,
    );

    return AlertDialog(
      backgroundColor: Colors.white,
      content: containerContent,
      actions: [
        const CancelButton(),
        SaveButton(onPressed: action),
      ],
    );
  }
}
