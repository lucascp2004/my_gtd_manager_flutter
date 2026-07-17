import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';

class SaveFutureButton extends StatefulWidget {
  final Future Function() onPressed;
  const SaveFutureButton({required this.onPressed, super.key});

  @override
  State<SaveFutureButton> createState() => _SaveFutureButtonState();
}

class _SaveFutureButtonState extends State<SaveFutureButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ContainerWithBorder(
      child: TextButton(
        key: const Key("SaveButton1"),
        onPressed: () async {
          if (isLoading) {
            return;
          }
          setState(() {
            isLoading = true;
          });
          await widget.onPressed().then((value) {
            if (context.mounted) Navigator.pop(context);
          });
        },
        child: (isLoading)
            ? Text(
                AppLocalizations.of(context)!.loading,
                style: ThemeText.black16Size,
              )
            : Text(
                AppLocalizations.of(context)!.save,
                style: ThemeText.black16Size,
              ),
      ),
    );
  }
}
