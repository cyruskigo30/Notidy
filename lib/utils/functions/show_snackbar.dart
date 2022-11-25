import 'package:flutter/material.dart';

///A function that displays errors to the user in an Alert dialog
showSnackBar(
  BuildContext context,
  String text,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
