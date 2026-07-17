import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/change_element_alert_dialog.dart';
import 'package:my_gtd_manager_2/controllers/element_base.dart';
import 'package:my_gtd_manager_2/controllers/int_controller.dart';
import 'package:my_gtd_manager_2/database/database.dart';

// ignore: must_be_immutable
class ChangeElementDialog extends StatefulWidget {
  final ElementBase elementData;

  late IntController listIdController;
  late IntController sublistIdController;

  ChangeElementDialog({required this.elementData, super.key});

  @override
  State<ChangeElementDialog> createState() => _ChangeElementDialogState();
}

class _ChangeElementDialogState extends State<ChangeElementDialog> {
  late ChangeElementSublist changeElementSublist;

  Future<ChangeElementSublist> getData() async {
    return await DatabaseDao.getChangeElementSublist(
      widget.elementData is MyElementData,
      widget.elementData.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AlertDialog(content: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.error),
            content: Text(AppLocalizations.of(context)!.localDataError),
          );
        } else {
          changeElementSublist = snapshot.data!;
          return ChangeElementAlertDialog(
            elementData: widget.elementData,
            listId: changeElementSublist.listId,
            sublistId: changeElementSublist.sublistId,
            sublistsStructure: changeElementSublist.sublistStructure,
          );
        }
      },
    );
  }
}
