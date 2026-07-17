import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/container_with_border.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class FutureButton2 extends StatefulWidget {
  final String questionLabel;
  final Future<void> Function() onpressed;
  final String buttonLabel;
  final String? saveLabel;
  final TextStyle? saveButtonTextStyle;
  final TextStyle? buttonTextStyle;
  final Function()? yesFunction;
  const FutureButton2({
    required this.onpressed,
    required this.buttonLabel,
    required this.questionLabel,
    this.yesFunction,
    this.saveLabel,
    this.buttonTextStyle,
    this.saveButtonTextStyle,
    super.key,
  });

  @override
  State<FutureButton2> createState() => _FutureButton2State();
}

class _FutureButton2State extends State<FutureButton2> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key("deleteButton"),
      onPressed: () async {
        setState(() {
          isLoading = true;
        });
        var result = await showSecondDialog(context);
        if (result) {
          widget.onpressed().then((_) {
            setState(() {
              isLoading = false;
            });
            if (widget.yesFunction != null) {
              widget.yesFunction!();
            }
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Text(
        (isLoading)
            ? AppLocalizations.of(context)!.loading
            : widget.buttonLabel,
        style: (widget.buttonTextStyle != null)
            ? widget.buttonTextStyle
            : ThemeText.darkblueLabelButton,
      ),
    );
  }

  Future<bool> showSecondDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(widget.questionLabel),
          actions: <Widget>[
            const CancelButton(key: Key("CancelButton2")),
            ContainerWithBorder(
              child: TextButton(
                child: Text(
                  key: const Key("finalDelete"),
                  (widget.saveLabel != null) ? widget.saveLabel! : "Ok",

                  style: (widget.saveButtonTextStyle != null)
                      ? widget.saveButtonTextStyle
                      : ThemeText.black16Size,
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ),
          ],
        );
      },
    );

    return confirmDelete == true;
  }
}
