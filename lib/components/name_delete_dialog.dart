import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/delete_button.dart';
import 'package:my_gtd_manager_2/components/save_button.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
typedef DelFunction = Future<void> Function();

class NameDeleteDialog extends StatefulWidget {
  final bool isProject;
  final bool isNew;
  final String? oldName;
  final DelFunction? delete;

  final Future<void> Function(String) setName;

  NameDeleteDialog({
    required this.isProject,
    required this.isNew,
    required this.setName,
    super.key,
    this.oldName,
    this.delete,
  }) {
    assert(
      (isNew == true && oldName == null && delete == null) ||
          (isNew == false && oldName != null),
    );
  }

  @override
  State<NameDeleteDialog> createState() => _NameDeleteDialogState();
}

class _NameDeleteDialogState extends State<NameDeleteDialog> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nameInput = TextEditingController();

  onpress() async {
    if (formkey.currentState!.validate()) {
      widget.setName(nameInput.text).then((_) {
        if (mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String objectStr = (widget.isProject)
        ? AppLocalizations.of(context)!.project
        : AppLocalizations.of(context)!.list;

    String confirmDeleteLabel = (widget.isProject)
        ? AppLocalizations.of(context)!.deleteConfirmation(objectStr, "este")
        : AppLocalizations.of(context)!.deleteConfirmation(objectStr, "esta");

    String titleIfNew = (widget.isProject)
        ? AppLocalizations.of(context)!.projectName
        : AppLocalizations.of(context)!.listName;

    String titleIfOld = (widget.isProject)
        ? AppLocalizations.of(context)!.newProjectName
        : AppLocalizations.of(context)!.newListName;

    String title = (widget.isNew) ? titleIfNew : titleIfOld;

    nameInput.text = (widget.isNew) ? '' : widget.oldName!;
    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              key: const Key("nameInput"),
              onFieldSubmitted: (value) {
                onpress();
              },
              validator: (String? value) {
                return (value != null && value.trim() == '')
                    ? AppLocalizations.of(context)!.emptyName
                    : null;
              },
              controller: nameInput,
              decoration: (widget.isNew)
                  ? InputDecoration(
                      hintText: titleIfNew,
                      hintStyle: ThemeText.hintStyle2,
                    )
                  : null,
            ),
            (widget.delete == null)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: DeleteButton(
                      onpressed: widget.delete!,
                      buttonLabel: AppLocalizations.of(context)!.del,
                      questionLabel: confirmDeleteLabel,
                    ),
                  ),
          ],
        ),
      ),
      actions: [
        const CancelButton(),
        SaveButton(onPressed: onpress),
      ],
    );
  }
}
