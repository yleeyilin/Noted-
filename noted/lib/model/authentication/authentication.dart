// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noted/view/login/verify.dart';
import 'package:noted/view/widgets/skeleton.dart';

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

void firebaseSignIn(String email, String password, BuildContext context) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password)
      .then((value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Skeleton(),
      ),
    );
  }).onError((error, stackTrace) {
    showErrorSnackbar(context, error);
  });
}

void resetPassword(String email, BuildContext context) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Reset Email Sent'),
          content: const Text(
              'Instructions to reset your password have been sent to your email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void changePassword(String email, String oldPassword, String newPassword,
    BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;
  AuthCredential credential =
      EmailAuthProvider.credential(email: email, password: oldPassword);
  user?.reauthenticateWithCredential(credential).then((AuthResult) {
    user.updatePassword(newPassword).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Skeleton(),
        ),
      );
    }).catchError((error) {
      // Password change failed
      showErrorSnackbar(context, error);
    });
  }).catchError((error) {
    // Reauthentication failed
    showErrorSnackbar(context, error);
  });
}

User? retrieveCurrUser() {
  return FirebaseAuth.instance.currentUser;
}
