import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

String getMessage(String code, BuildContext context) {
  var decodeError = {
    "network-request-failed": AppLocalizations.of(
      context,
    )!.networkRequestFailed,
    "signIn-error": AppLocalizations.of(context)!.signInError,
    "email-already-in-use": AppLocalizations.of(context)!.emailAlreadyInUse,
    "invalid-email": AppLocalizations.of(context)!.invalidEmail,
    "weak-password": AppLocalizations.of(context)!.weakPassword,
    "signup-error": AppLocalizations.of(context)!.signUpError,
    'invalid-credential': AppLocalizations.of(context)!.invalidCredenditals,
    "user-disabled": AppLocalizations.of(context)!.userDisabled,

    "email-recovery-error": AppLocalizations.of(context)!.emailRecoveryError,
    "backup-error": AppLocalizations.of(context)!.getBackupError,
    "email-not-send": AppLocalizations.of(context)!.signUpMessage2,
    "check-email": AppLocalizations.of(context)!.verifyEmail,
  };
  return decodeError[code]!;
}
