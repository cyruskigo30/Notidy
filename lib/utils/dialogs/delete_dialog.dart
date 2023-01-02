import 'package:flutter/material.dart';
import 'generic_dialog.dart';

/// A logout dialog that get's its temlate from the generic dialog
/// it is a bollean because it has two options cancel or logout
Future<bool> showDeleteDialog(BuildContext context) {
  ///show return dialog will return a boolean value
  return showGenericDialog<bool>(
      context: context,

      ///title of the button
      title: 'Delete',
      content: 'Are you sure you want to delete this item?',

      ///a function taht returns a  map
      optionsBuilder: () => {
            'Cancel': false,
            'Yes': true,

            ///there are some platforms especially android that can dismiss the alert dialog
            ///without using any of the button eg by clicking outside the alert dialog or the back button
            ///use then to cover that option by asking app either to return the value above or false
            ///which dismisses or cancels the alert / signout dialog
          }).then((value) => value ?? false);
}
