import 'package:evently_6/ui/data_models/user_dm.dart';
import 'package:evently_6/ui/utils/app_dialogs.dart';
import 'package:evently_6/ui/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firestore_utility.dart';

String webClientId =
    '1026470521370-pggpe65u5t5ac18h6vhifsdi0o54fqvq.apps.googleusercontent.com';

Future<void> initGoogleSignIn() async {
  await GoogleSignIn.instance.initialize(serverClientId: webClientId);
}

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    if (googleAuth.idToken == null) {
      return;
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    UserDm.currentUser = await getUserFromFirestore(userCredential.user!.uid);
    Navigator.pop(context);
    Navigator.push(context, AppRoutes.navigationScreen);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    var message = e.message ?? "Something went wrong, please try again later";
    showMessage(
      context,
      message,
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  } on Exception catch (_) {
    Navigator.pop(context);
    showMessage(
      context,
      "Google sign-in failed. Please try again.",
      title: "Error",
      posText: "Ok",
      onPosClick: () => Navigator.pop(context),
    );
  }
}

Future<void> signInWithEmailPassword(
  BuildContext context, {
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) async
{
  try {
    showLoading(context);
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    UserDm.currentUser = await getUserFromFirestore(credential.user!.uid);
    Navigator.pop(context);
    Navigator.push(context, AppRoutes.navigationScreen);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    var message = "";
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided for that user.';
    } else {
      message = e.message ?? "Something went wrong, please, try again later";
    }
    showMessage(
      context,
      message,
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  }
}

Future<void> signUpWithGoogle(
  BuildContext context, {
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController phoneController,
}) async
{
  try {
    showLoading(context);

    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();

    if (googleUser == null) {
      Navigator.pop(context);
      return;
    }

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    if (googleAuth.idToken == null) {
      throw Exception('No ID token from Google');
    }

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );

    final firebaseUser = userCredential.user;
    if (firebaseUser == null) {
      throw Exception('No user returned');
    }

    if (firebaseUser.displayName == null || firebaseUser.displayName!.isEmpty) {
      await firebaseUser.updateDisplayName(googleUser.displayName);
    }

    UserDm.currentUser = UserDm(
      id: firebaseUser.uid,
      name: googleUser.displayName ?? nameController.text,
      email: googleUser.email ?? emailController.text,
      phoneNumber: phoneController.text,
    );

    await createUserInFirestore(UserDm.currentUser!);

    Navigator.pop(context);
    Navigator.push(context, AppRoutes.navigationScreen);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);

    String message =
        e.message ?? "Something went wrong, please try again later";
    if (e.code == 'account-exists-with-different-credential') {
      message =
          'An account already exists with a different sign-in method for that email.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The email is already in use by another account.';
    } else if (e.code == 'operation-not-allowed') {
      message = 'Google sign-in is not enabled.';
    } else if (e.code == 'invalid-credential') {
      message = 'Invalid Google credentials.';
    }

    showMessage(
      context,
      message,
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  } catch (e) {
    Navigator.pop(context);
    showMessage(
      context,
      "Google sign-up failed. Please try again.",
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  }
}

Future<void> signUpWithEmailPassword(
  BuildContext context, {
  required TextEditingController nameController,
  required TextEditingController emailController,
  required TextEditingController phoneController,
  required TextEditingController passwordController,
}) async
{
  try {
    showLoading(context);
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
    UserDm.currentUser = UserDm(
      id: credential.user!.uid,
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
    );
    createUserInFirestore(UserDm.currentUser!);
    Navigator.pop(context);
    Navigator.push(context, AppRoutes.navigationScreen);
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    var message = "";
    if (e.code == 'weak-password') {
      message = 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      message = 'The account already exists for that email.';
    } else {
      message = e.message ?? "Something went wrong, please, try again later";
    }
    showMessage(
      context,
      message,
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  } catch (e) {
    showMessage(
      context,
      "Something went wrong, please, try again later",
      title: "Error",
      posText: "Ok",
      onPosClick: () {
        Navigator.pop(context);
      },
    );
  }
}
