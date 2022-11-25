import 'package:flutter/material.dart';

///A function that displays errors to the user in an Alert dialog
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Error ! !',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
            ///dismiss the pop up
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'ok',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      );
    },
  );
}
