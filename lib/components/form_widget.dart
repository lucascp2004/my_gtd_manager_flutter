import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/components/custom_textformfield.dart';
import 'package:my_gtd_manager_2/components/future_button.dart';
import 'package:my_gtd_manager_2/components/text_label.dart';
import 'package:my_gtd_manager_2/validators.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';

class MyForm extends StatefulWidget {
  final bool isLoading;
  final String buttonLabel;
  final TextEditingController emailInput;
  final TextEditingController passwordInput;
  final Future<void> Function() formFunction;
  final GlobalKey<FormState> formKey;

  const MyForm({
    required this.isLoading,
    required this.emailInput,
    required this.passwordInput,
    required this.formFunction,
    required this.buttonLabel,
    required this.formKey,
    super.key,
  });

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextLabel(AppLocalizations.of(context)!.email),
          CustomTextFormField(
            key: const Key("emailField"),
            input: widget.emailInput,
            onSubmitted: (value) {
              widget.formFunction();
            },
            hint: "Email",
            validator: Validator.emailValidator(context),
          ),
          TextLabel(AppLocalizations.of(context)!.password),
          CustomTextFormField(
            obscure: true,
            key: const Key("passwordField"),
            onSubmitted: (value) {
              widget.formFunction();
            },
            input: widget.passwordInput,
            hint: "Password",
            validator: Validator.passwordValidator(context),
          ),
          const SizedBox(height: 25),
          MyElevatedButton(
            key: Key(widget.buttonLabel),
            isLoading: widget.isLoading,
            onPressed: widget.formFunction,

            child: TextLabel(widget.buttonLabel),
          ),
        ],
      ),
    );
  }
}
