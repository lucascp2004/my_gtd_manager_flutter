import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/text_label.dart';
import 'package:my_gtd_manager_2/components/theme/theme_colors.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final void Function() onPressed;
  const MyElevatedButton({
    required this.onPressed,
    required this.child,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 40),
        backgroundColor: MyColors.futureButton,
      ),
      onPressed: onPressed,

      child: getChild(context),
    );
  }

  Widget getChild(BuildContext context) {
    if (isLoading) {
      return TextLabel(AppLocalizations.of(context)!.loading);
    } else {
      return child;
    }
  }
}
