import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/auth/auth_service.dart';
import 'package:my_gtd_manager_2/auth/errors_map.dart';
import 'package:my_gtd_manager_2/components/form_widget.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  bool isLoading1 = false;

  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading1 = true;
      });
      var email = emailInput.text.trim();
      var password = passwordInput.text;
      AuthService.emailSignUp(email, password).then((result) async {
        if (result == "success") {
          if (mounted) {
            await ShowMessages.showMessage(
              AppLocalizations.of(context)!.signUpMessage1,
              context,
            );
          }
        } else {
          if (mounted) {
            var errorMessage = getMessage(result, context);
            debugPrint("DECODE MESSAGE:$errorMessage");
            await ShowMessages.showMessage(errorMessage, context);
          }
        }
        setState(() {
          isLoading1 = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String buttonLabel = AppLocalizations.of(context)!.signUp;
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up page")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyForm(
              isLoading: isLoading1,
              formKey: formKey,
              emailInput: emailInput,
              passwordInput: passwordInput,
              formFunction: signUp,
              buttonLabel: buttonLabel,
            ),
          ),
        ],
      ),
    );
  }
}
