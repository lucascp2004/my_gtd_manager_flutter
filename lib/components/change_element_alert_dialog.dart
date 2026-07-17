import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/delete_element_button.dart';
import 'package:my_gtd_manager_2/components/dropdraw.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/components/rounded_container.dart';
import 'package:my_gtd_manager_2/components/save_future_button.dart';
import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/controllers/my_element_controller.dart';
import '../database/database.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

// ignore: must_be_immutable
class ChangeElementAlertDialog extends StatefulWidget {
  final ElementController controller;
  final ElementBase elementData;

  Map<ListLite, List<SublistWithId>> sublistsStructure;
  ChangeElementAlertDialog({
    required this.elementData,
    required this.sublistsStructure,
    required int listId,
    required int sublistId,
    super.key,
  }) : controller = ElementController(
         name: elementData.name,
         notes: elementData.notes,
         id: elementData.id,
         listId: listId,
         sublistId: sublistId,
         isItem: elementData is MyElementData,
       );

  @override
  State<ChangeElementAlertDialog> createState() =>
      _ChangeElementAlertDialogState();
}

class _ChangeElementAlertDialogState extends State<ChangeElementAlertDialog> {
  Future<void> changeElementName() async {
    var text = widget.controller.getName();
    var notes = widget.controller.getNotes();

    if ((text != widget.elementData.name && text != '') ||
        (notes != widget.elementData.notes)) {
      await DatabaseDao.changeElementName(
        text,
        widget.elementData.id,
        widget.controller.isItem,
        notes,
      );
    }
  }

  Widget content() {
    var isItem = widget.controller.isItem;
    var listLabel = AppLocalizations.of(context)!.list;
    var sublistLabel = AppLocalizations.of(context)!.folder;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RoundedContainer(
              Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    TextField(
                      key: const Key("nameInput"),
                      controller: widget.controller.name,
                      onSubmitted: (value) async {
                        await actions().then((value) {
                          if (mounted) {
                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              Colors.white,
              border: Border.all(),
            ),
            const SizedBox(height: 10),
            RoundedContainer(
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$listLabel:'),
                    MyDropdown(
                      dropdawn1values(),
                      widget.controller.listIdController,
                      afterSetState: dropdawn1func,
                      key: const Key("dropdown1"),
                    ),
                    Text('$sublistLabel:'),
                    MyDropdown(
                      dropdawn2values(),
                      widget.controller.sublistIdController,
                      key: const Key("dropdown2"),
                    ),
                    const SizedBox(height: 5),
                    (!isItem)
                        ? DeleteElementButton(
                            hasRelatedItems: false,
                            id: widget.elementData.id,
                            type: ElementType.folder,
                          )
                        : DeleteElementButton(
                            type: ElementType.item,

                            id: widget.elementData.id,
                            hasRelatedItems: widget.elementData
                                .hasRelatedItem(),
                          ),
                  ],
                ),
              ),
              Colors.white,
              border: Border.all(),
            ),
            const SizedBox(height: 10),
            RoundedContainer(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NotesWidget(
                  borderside: const BorderSide(color: Colors.black),
                  notesInput: widget.controller.notes,
                ),
              ),
              Colors.white,
              border: Border.all(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteSublist() {
    return DatabaseDao.deleteSublist(widget.elementData.id);
  }

  Future<void> actions() async {
    await changeElementName();
    await moveItem();
  }

  moveItem() async {
    var list = widget.controller.listIdController.value;
    var sublist = widget.controller.sublistIdController.value;
    if (list != widget.controller.listId ||
        sublist != widget.controller.sublistId) {
      await DatabaseDao.changeElementParent(
        isItem: widget.controller.isItem,
        elementId: widget.controller.id,
        sublistId: sublist,
        listId: list,
      );
    }
  }

  void dropdawn1func() {
    int list = widget.controller.listIdController.value;

    setState(() {
      if (list == widget.controller.listId) {
        widget.controller.sublistIdController.value =
            widget.controller.sublistId;
      } else {
        widget.controller.sublistIdController.value = -1;
      }
    });
  }

  Map<String, int> dropdawn2values() {
    int list = widget.controller.listIdController.value;
    List<SublistWithId> sublists = [];
    for (var key in widget.sublistsStructure.keys) {
      if (key.id == list) {
        sublists = widget.sublistsStructure[key]!;
        break;
      }
    }
    sublists.insert(
      0,
      SublistWithId(-1, AppLocalizations.of(context)!.noFolder),
    );

    Map<String, int> result = {};

    for (var sublist in sublists) {
      result[sublist.name] = sublist.sublistId;
    }

    return result;
  }

  Map<String, int> dropdawn1values() {
    Map<String, int> result = {};
    for (var key in widget.sublistsStructure.keys) {
      result[key.name] = key.id;
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var windowText = (widget.controller.isItem)
        ? AppLocalizations.of(context)!.changeItem
        : AppLocalizations.of(context)!.changeFolder;
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      title: Text(windowText),
      content: content(),
      actions: [
        const CancelButton(),
        SaveFutureButton(onPressed: actions),
      ],
    );
  }
}
