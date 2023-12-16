import 'package:flutter/material.dart';
import 'package:todoapp/utils/colors.dart';

void successMessage(BuildContext context, String successmessage) {
  final snackbar = SnackBar(
    content: Text(successmessage),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void errorMessage(BuildContext context, String errormessage) {
  final snackbar = SnackBar(
    backgroundColor: redcolor,
    content: Text(
      errormessage,
      style: const TextStyle(color: whitecolor),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
