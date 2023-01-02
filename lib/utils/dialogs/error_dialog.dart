import 'package:flutter/material.dart';
import 'generic_dialog.dart';

/// An error dialog that get's its template from the generic dialog
///this just show error dialog that doesnt return anything (void)
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'An error occured',
    content: text,

    ///A function that returns a map
    optionsBuilder: () => {
      ///the key is ok with a value of null
      'OK': null,
    },
  );
}
