import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/custom_check_button.dart';
import 'package:my_gtd_manager_2/components/future_button2.dart';
import 'package:my_gtd_manager_2/components/rounded_container_on_top.dart';
import 'package:my_gtd_manager_2/components/theme/theme_colors.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/theme/theme_text.dart';
import 'package:my_gtd_manager_2/controllers/task_block_events.dart';

class BaseBoard extends StatelessWidget {
  final Stream<TaskBlocEvent> stream;
  final Future<void> Function(bool) onCheck;
  final Future<void> Function()? buttonfunction;

  const BaseBoard(this.stream, this.onCheck, {this.buttonfunction, super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = StreamBuilder<TaskBlocEvent>(
      stream: stream,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Text(AppLocalizations.of(context)!.localDataError);
        }
        if (!snapshot.hasData) {
          return Text(AppLocalizations.of(context)!.loading);
        }
        var value = (snapshot.data! as ShowAllEvent).showAll;
        return Row(
          mainAxisAlignment: (buttonfunction == null)
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomCheckButton(value, onCheck, "showall cb"),
                Text(
                  AppLocalizations.of(context)!.showAll,
                  style: ThemeText.black16Size,
                ),
              ],
            ),
            (buttonfunction == null)
                ? Container()
                : FutureButton2(
                    questionLabel: AppLocalizations.of(
                      context,
                    )!.unselectAllQuestion,
                    onpressed: buttonfunction!,
                    saveButtonTextStyle: ThemeText.black16Size,
                    saveLabel: "Ok",
                    buttonLabel: AppLocalizations.of(context)!.unselectAll,
                  ),
          ],
        );
      }),
    );

    return SizedBox(
      height: 48,
      child: RoundedContainerOnTop(content, MyColors.baseboard),
    );
  }
}
