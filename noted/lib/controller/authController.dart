import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:noted/model/query/createNode.dart';
import 'package:noted/model/authentication/authentication.dart';
import 'package:noted/view/login/verify.dart';
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
}
