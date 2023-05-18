import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, dynamic error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error ${error.toString()}"),
    ),
  );
}