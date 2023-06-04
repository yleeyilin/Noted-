import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noted/view/login/verify.dart';

void showErrorSnackbar(BuildContext context, dynamic error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error ${error.toString()}"),
    ),
  );
}

bool authentication(
    String email, String reset, String password, BuildContext context) {
  if (email.endsWith("@u.nus.edu") && reset == password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      value.user!.sendEmailVerification().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Verify(),
          ),
        );
      }).catchError((error) {
        print(error.toString());
        showErrorSnackbar(context, "Failed to send email verification.");
      });
    }).catchError((error) {
      // Failed to create user
      print(error.toString());
      showErrorSnackbar(context, "Failed to create user.");
    });
    return true;
  }
  return false;
}
