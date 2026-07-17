import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/delete_element_button.dart';
import 'package:my_gtd_manager_2/components/notes_widget.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/dates_function.dart';
import 'package:my_gtd_manager_2/database/database.dart';

class CompletedTaskForm extends StatefulWidget {
  final TaskData task;
  const CompletedTaskForm(this.task, {super.key});
  @override
  State<CompletedTaskForm> createState() => _CompletedTaskFormState();
}

class _CompletedTaskFormState extends State<CompletedTaskForm> {
  TextEditingController nameInput = TextEditingController();
  late DateTime dateTask;
  TextEditingController notesInput = TextEditingController();

  @override
  initState() {
    var task = widget.task;
    nameInput.text = task.name;

    dateTask = stringToDateTime(task.startingDay)!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var title = AppLocalizations.of(context)!.changeTask;

    var formatter = DateFormat.yMd();
    String formattedDate = formatter.format(dateTask);

    return AlertDialog(
      title: Text(title),
      actions: [
        ContainerWithBorder(
          child: TextButton(
            key: const Key("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK", style: ThemeText.black16Size),
          ),
        ),
      ],

      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                readOnly: true,
                key: const Key("taskInput"),
                controller: nameInput,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.dateTasK),
                  Text(formattedDate),
                ],
              ),

              const SizedBox(height: 10),
              NotesWidget(notesInput: notesInput, readOnly: true),
              const SizedBox(height: 10),

              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ContainerWithBorder(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.unfinishTask,
                          style: ThemeText.darkblueLabelButton,
                        ),
                        onPressed: () {
                          DatabaseDao.unfinishTask(
                            widget.task.id,
                            widget.task.relatedElementId,
                          ).then((_) {
                            if (context.mounted) Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    DeleteElementButton(
                      id: widget.task.id,
                      projectIdRelated: widget.task.relatedElementId,
                      hasRelatedItems: widget.task.relatedElementId != null,
                      type: ElementType.task,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
