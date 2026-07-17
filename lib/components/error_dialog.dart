import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

AlertDialog errorDialog(BuildContext context) {
  return AlertDialog(
    title: Text(AppLocalizations.of(context)!.error),
    content: Text(AppLocalizations.of(context)!.localDataError),
  );
}
