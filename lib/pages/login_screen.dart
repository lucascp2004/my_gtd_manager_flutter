import 'package:flutter/material.dart';
import 'package:my_gtd_manager_2/l10n/app_localizations.dart';
import 'package:my_gtd_manager_2/auth/auth_service.dart';
import 'package:my_gtd_manager_2/auth/errors_map.dart';
import 'package:my_gtd_manager_2/components/forgot_password_dialog.dart';
import 'package:my_gtd_manager_2/components/form_widget.dart';
import 'package:my_gtd_manager_2/components/future_button.dart';
import 'package:my_gtd_manager_2/components/show_messages.dart';
import 'package:my_gtd_manager_2/components/text_label.dart';
import 'package:my_gtd_manager_2/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailInput = TextEditingController();
  final passwordInput = TextEditingController();
  bool isLoading = false;
  bool isLoadingEmailLogin = false;
  bool isLoadingGoogleLogin = false;
  bool isLoadingForgotPassword = false;

  Future<void> forgotPassword() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ForgotPasswordDialog();
      },
    );
  }

  Future<void> login() async {
    if (isLoading) return;
    setState(() {
      isLoadingEmailLogin = true;
      isLoading = true;
    });
    if (formKey.currentState!.validate()) {
      debugPrint("tudo valido");
      var email = emailInput.text.trim();
      var password = passwordInput.text;
      debugPrint("vai logar");
      AuthService.signInWithEmailAndPassword(email, password).then((
        result,
      ) async {
        debugPrint("set state");
        debugPrint("tentou logar");
        debugPrint("result:$result");
        setState(() {
          isLoadingEmailLogin = false;
          isLoading = false;
        });
        if (result == "success") {
          router.go("/lists");
        } else {
          if (mounted) {
            await ShowMessages.showMessage(
              getMessage(result, context),
              context,
            );
          }
        }
      });
    } else {
      setState(() {
        isLoadingEmailLogin = false;
        isLoading = false;
      });
    }
  }

  Future<void> googleLogin() async {
    if (isLoading) return;
    setState(() {
      isLoadingGoogleLogin = true;
      isLoading = true;
    });
    AuthService.signInWithGooglePart1().then((result) {
      setState(() {
        isLoadingGoogleLogin = false;
        isLoading = false;
      });
      if (result) router.go("/lists");
    });
  }

  @override
  Widget build(BuildContext context) {
    String buttonLabel = AppLocalizations.of(context)!.logIn;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Column(
            children: [
              MyForm(
                isLoading: isLoadingEmailLogin,
                formKey: formKey,
                emailInput: emailInput,
                passwordInput: passwordInput,
                formFunction: login,
                buttonLabel: buttonLabel,
              ),

              MyElevatedButton(
                isLoading: isLoadingGoogleLogin,

                onPressed: googleLogin,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/background.png', height: 40, width: 40),
                    TextLabel(AppLocalizations.of(context)!.signUpWithGoogle),
                  ],
                ),
              ),
              MyElevatedButton(
                onPressed: forgotPassword,

                isLoading: isLoadingForgotPassword,
                child: TextLabel(AppLocalizations.of(context)!.forgotPassword),
              ),
              MyElevatedButton(
                key: const Key("Sing up screen"),
                onPressed: () {
                  if (isLoading) return;
                  router.go("/login/signup");
                },
                isLoading: false,
                child: TextLabel(AppLocalizations.of(context)!.signUpPage),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
