import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/future_button2.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class DeleteButton extends StatelessWidget {
  final String questionLabel;
  final Future<void> Function() onpressed;
  final String buttonLabel;
  const DeleteButton({
    required this.questionLabel,
    required this.onpressed,
    required this.buttonLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      child: FutureButton2(
        buttonTextStyle: ThemeText.deleteButton,
        onpressed: onpressed,
        buttonLabel: buttonLabel,
        questionLabel: questionLabel,
        saveButtonTextStyle: ThemeText.deleteButton,
        saveLabel: AppLocalizations.of(context)!.del,
        yesFunction: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
