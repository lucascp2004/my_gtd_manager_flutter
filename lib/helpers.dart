import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

const url = 'https://www.youtube.com/watch?v=95NjEHv55w0';
mylaunchURL(BuildContext context) async {
  var uri = Uri.parse(url);
  canLaunchUrl(uri).then((canLaunch) async {
    if (!canLaunch) {
      if (context.mounted) await youtubeMessage(context);
    } else {
      await launchUrl(uri);
    }
  });
}

void myPrint(String text) {
  debugPrint("######\n######\n\n$text\n#######\n#######");
}

void safePop(BuildContext context) {
  if (context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> youtubeMessage(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text('${AppLocalizations.of(context)!.youtubeError} $url'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      );
    },
  );
}

List<int> filterIntList(List<int> big, List<int> small) {
  List<int> result = [];
  if (big.length == small.length) return result;
  var cont1 = 0;
  var cont2 = 0;

  while (cont1 < big.length) {
    if (cont2 != small.length && big[cont1] == small[cont2]) {
      cont1++;
      cont2++;
    } else {
      result.add(big[cont1]);
      cont1++;
      if ((cont1 - cont2) == (big.length - small.length)) break;
    }
  }

  return result;
}
