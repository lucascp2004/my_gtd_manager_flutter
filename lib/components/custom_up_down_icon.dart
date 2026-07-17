import 'package:flutter/material.dart';

import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/database/database.dart';

import 'show_messages.dart';
import 'theme/theme_colors.dart';

class UpDownIcon extends StatelessWidget {
  final int value;
  final int listID;

  const UpDownIcon(this.value, this.listID, {super.key});

  Future<void> setIsShrinked() async {
    if (value == 2) return;

    await DatabaseDao.changeIsShrinked(
      (value !=
          0), //if value is 0 change to false, if value is 1 change to true
      listID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key("$listID -"),
      iconSize: 30,

      color: MyColors.upDownIconColor,
      onPressed: () async {
        setIsShrinked().catchError((error) {
          if (context.mounted) {
            ShowMessages.messageSnackBar(
              AppLocalizations.of(context)!.localDataError,
              context,
            );
          }
        });
      },
      icon: getIcon(),
      padding: const EdgeInsets.all(9),
      constraints: const BoxConstraints(),
    );
  }

  Widget getIcon() {
    if (value == 0) {
      return const Icon(color: Colors.black54, Icons.expand_more);
    } else if (value == 1) {
      return const Icon(color: Colors.black54, Icons.expand_less);
    } else if (value == 2) {
      return const Icon(color: Colors.black54, Icons.remove);
    } else {
      throw Exception("value not valid");
    }
  }
}
