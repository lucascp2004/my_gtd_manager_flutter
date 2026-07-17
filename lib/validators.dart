import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class Validator {
  static FormFieldValidator<String> passwordValidator(BuildContext context) {
    var passwordError = AppLocalizations.of(context)!.passwordError;
    return (String? value) {
      if (value == null) return passwordError;
      if (value.length < 8) {
        return passwordError;
      } else {
        return null;
      }
    };
  }

  static FormFieldValidator<String> emailValidator(BuildContext context) {
    var emailError = AppLocalizations.of(context)!.emailError;
    return (String? value) {
      if (value == null) return emailError;
      if (EmailValidator.validate(value.trim())) {
        return null;
      } else {
        return emailError;
      }
    };
  }

  static FormFieldValidator<String> notEmpty(BuildContext context) {
    var empty = AppLocalizations.of(context)!.emptyError;
    return (String? value) {
      if (value == null) return empty;
      if (value.trim().isNotEmpty) {
        return null;
      } else {
        return empty;
      }
    };
  }
}
