import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/neo4j/createNode.dart';
import 'package:noted/model/authentication/authentication.dart';
import 'package:flutter/material.dart';

class AuthController extends ControllerMVC {
  factory AuthController() => _this ??= AuthController._();
  AuthController._();
  static AuthController? _this;

  void authenticate(String email, String reset, String password, String name,
      BuildContext context) {
    if (authentication(email, reset, password, context)) {
      createUserNode(name, email);
    } else {
      showErrorSnackbar(context, "Invalid authentication.");
    }
  }

  void signin(String email, String password, BuildContext context) {
    firebaseSignIn(email, password, context);
  }

  void reset(String email, BuildContext context) {
    resetPassword(email, context);
  }

  void change(String email, String oldPassword, String newPassword,
      String rNewPassword, BuildContext context) {
    if (newPassword == rNewPassword) {
      changePassword(email, oldPassword, newPassword, context);
    } else {
      showErrorSnackbar(context, "Passwords do not match.");
    }
  }
}
