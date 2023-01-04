import 'package:flutter/material.dart';
import 'generic_dialog.dart';

///this dialog prevents sharing of an  empty note
Future<void> showCannotShareEmptyNote(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'Sorry, You Cannot Share an Empty Note',

    ///returns a map with button options
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
