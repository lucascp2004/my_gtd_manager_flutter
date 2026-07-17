import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

import 'package:my_gtd_manager_2/components/radio_group.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';

class BaseInsertElement extends StatefulWidget {
  final int ancestorId;
  final bool isSublist;

  final IntController optionController;
  final TextEditingController textInput;
  //final bool isRow;
  final Function(String) onSubmitted;

  const BaseInsertElement({
    required this.optionController,
    required this.textInput,

    required this.isSublist,
    required this.ancestorId,
    required this.onSubmitted,
    //required this.isRow,
    super.key,
  });

  /*String getText() {
    return textInput.text;
  }

  int getOption() {
    return optionController.value;
  }*/

  @override
  State<BaseInsertElement> createState() => _BaseInsertElementState();
}

class _BaseInsertElementState extends State<BaseInsertElement> {
  @override
  Widget build(BuildContext context) {
    List<String> options = [
      AppLocalizations.of(context)!.newItem,
      AppLocalizations.of(context)!.newFolder,
    ];
    TextField textField = TextField(
      key: (!widget.isSublist)
          ? const Key("inputList")
          : const Key("inputSublist"),
      maxLines: 1,
      decoration: InputDecoration(
        hintStyle: ThemeText.hintStyle2,
        hintText: AppLocalizations.of(context)!.newElementHint,
        isDense: true,
        //contentPadding: EdgeInsets.zero
      ),
      controller: widget.textInput,
      onSubmitted: widget.onSubmitted,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: textField,
          ),
        ),
        (!widget.isSublist)
            ? MyRadioGroup(
                !widget.isSublist,
                options,
                widget.optionController,
                true,
              )
            : MyRadioGroup(
                !widget.isSublist,
                options,
                widget.optionController,
                false,
              ),
      ],
    );
  }
}
