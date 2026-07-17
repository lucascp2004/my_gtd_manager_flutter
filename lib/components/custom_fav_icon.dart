/*import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/database/database.dart';

import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

import 'theme/theme_colors.dart';

class FavButton extends StatelessWidget {
  final bool value;

  final int itemId;
  const FavButton(this.value, this.itemId, {super.key});

  

  @override
  Widget build(BuildContext context) {
    var keyName = "$itemId fav";
    
    return IconButton(
      key: Key(keyName),
      iconSize: 30,
      color: getColor(),
      onPressed: () async {
        //debugPrint("setFavValue");
        setValue(!value).catchError((error) {
          ShowMessages.messageSnackBar(
              AppLocalizations.of(context)!.localDataError, context);
        });
      },
      icon: Icon(getIcon()),
      padding: const EdgeInsets.all(9),
      constraints: const BoxConstraints(),
    );
  }

  IconData getIcon() {
    return (value) ? Icons.star_sharp : Icons.star_border;
  }

  Color getColor() {
    return (value) ? ThemeColors.favColor : ThemeColors.notfavColor;
  }
}
*/
