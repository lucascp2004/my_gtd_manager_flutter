import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/auth/auth_service.dart';
import 'package:my_gtd_manager_2/auth/errors_map.dart';
import 'package:my_gtd_manager_2/components/cancel_button.dart';
import 'package:my_gtd_manager_2/components/custom_textformfield.dart';
import 'package:my_gtd_manager_2/components/rounded_button.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/validators.dart';

class ForgotPasswordDialog extends StatefulWidget {
  const ForgotPasswordDialog({super.key});

  @override
  State<ForgotPasswordDialog> createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailInput = TextEditingController();
  Future<void> formFunction() async {
    AuthService.passwordRecovery(emailInput.text.trim()).then((result) async {
      if (result == "success") {
        if (mounted) {
          await ShowMessages.showMessageAndPop(
            AppLocalizations.of(context)!.emailRecovery,
            context,
          );
        }
      } else {
        if (mounted) {
          var msg = getMessage(result, context);
          await ShowMessages.showMessageAndPop(msg, context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var emailLabel = AppLocalizations.of(context)!.email;
    var okLabel = AppLocalizations.of(context)!.ok;
    return AlertDialog(
      title: Text(emailLabel),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              hint: emailLabel,
              input: emailInput,
              validator: Validator.emailValidator(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CancelButton(),
                RoundedButton(okLabel, formFunction),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
