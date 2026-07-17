import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_gtd_manager_2/database/database.dart';
import 'package:my_gtd_manager_2/firebase/backup.dart';
import 'package:my_gtd_manager_2/firebase_options.dart';
import 'package:my_gtd_manager_2/helpers.dart';

class AuthService {
  static Future<void> sendEmail() async {
    assert(FirebaseAuth.instance.currentUser != null);

    FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  static Future<String> emailSignUp(String email, String password) async {
    final UserCredential authResult;
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint("ERROR CODE: ${error.code}");
      return error.code;
    } catch (error) {
      debugPrint("STRANGE ERROR: $error");
      return "signup-error";
    }
    User? user = authResult.user;
    if (user == null) return "signup-error";
    try {
      user.sendEmailVerification();
      return "success";
    } catch (error) {
      return "email-not-send";
    }
  }

  static bool userOk() {
    return FirebaseAuth.instance.currentUser!.emailVerified == true;
  }

  static Future<bool> hasCredential() async {
    assert(await DatabaseDao.getLogin() != 0);
    if (isAuthenticated()) {
      return true;
    }

    if (await DatabaseDao.getLogin() == 1) {
      return await signInWithGooglePart1();
    } else {
      try {
        final email = await DatabaseDao.getEmail();
        final password = await DatabaseDao.getPassword();

        UserCredential auth = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!);
        if (auth.user != null) {
          return true;
        } else {
          return false;
        }
      } catch (error) {
        //debugPrint("não recuperou credenciais por que deu ruim");
        return false;
      }
    }
  }

  static User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static bool isAuthenticated() {
    return getUser() != null;
  }

  static Future<String> passwordRecovery(String email) async {
    //1 ok
    //something else error message
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseAuthException catch (error) {
      //debugPrint("PasswordRecovery code error:${error.code}");
      switch (error.code) {
        case "invalid-email":
          return error.code;
        case "user-not-found":
          return error.code;
        case "network-request-failed":
          return error.code;
        default:
          return "email-recovery-error";
      }
    }
  }

  static Future<bool> signInWithGooglePart1() async {
    debugPrint('Google sign in part1');
    //String? accessToken;
    String? idToken;
    //await Future.delayed(const Duration(seconds: 10));
    try {
      var googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId: DefaultFirebaseOptions.android.authDomain,
      );
      final GoogleSignInAccount googleSignInAccount = await googleSignIn
          .authenticate();

      var googleAuth = googleSignInAccount.authentication;

      idToken = googleAuth.idToken;
      final AuthCredential credential = GoogleAuthProvider.credential(
        //accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential authResult = await FirebaseAuth.instance
          .signInWithCredential(credential);
      if (authResult.user == null) {
        debugPrint("Google signIn fail 2");
        return false;
      }
    } catch (error, stackTrace) {
      debugPrint("Error: $error");
      myPrint("$stackTrace");
      return false;
    }
    await DatabaseDao.setLogin(1);
    return true;
  }

  static Future<bool> signInPart2() async {
    debugPrint("Sign in part 2");

    final hasBackup = await Backup.checkOnlineBackup();
    if (hasBackup == 3) {
      debugPrint("error checking backup");
      AuthService.signOut();
      return false;
    } else if (hasBackup == 1) {
      myPrint("No backup");
      await DatabaseDao.deleteAll(true);

      return true;
    } else {
      myPrint("has backup");

      myPrint("vai pegar back up");
      await Backup.getBackup();
      return true;
      //extra code
      //fim extra code

      /*try {
        debugPrint("vai pegar back up");
        
        await Backup.getBackup();
        
        return true;
      } catch (e) {
        debugPrint("Pegar backup não deu certo");
        debugPrint("error: $e");
        return false;
      }*/
    }
  }

  static Future<bool> signInWithGoogle() async {
    final noError = await signInWithGooglePart1();
    final hasError = !noError;
    if (hasError) return false;

    return await signInPart2();
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    //1 user did not click verification link
    //2 user clicked verification link
    //something else error message
    final UserCredential authResult;
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint("Error code:${error.code}");
      return error.code;
    } on Exception {
      debugPrint('Unknown error');
      return "signIn-error";
    }
    User? user = authResult.user;
    if (user == null) {
      return "signIn-error";
    }
    await DatabaseDao.setEmail(email);
    await DatabaseDao.setPassword(password);

    debugPrint("database setted");
    if (user.emailVerified) {
      final noError = await signInPart2();
      if (noError) {
        await DatabaseDao.setLogin(2);
        return "success";
      } else {
        return "backup-error";
      }
    } else {
      try {
        await sendEmail();
        return "check-email";
      } catch (error) {
        return "signIn-error";
      }
    }
  }
}
