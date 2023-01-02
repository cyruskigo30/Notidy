import 'package:flutter/material.dart';
import 'package:notidy/utils/theme/colors.dart';

///generic is meant to produce different kinds of values
///sometimes it returns true or false
///sometimes other results based on wht it is provided with
///The buttons in the dialog will have a datatype let's call it
/// we need to enable the user to declare a list of buttons they may need for the dialog
/// this means that it allows for declaration of multiple buttons and each button to have a callback function
/// and a title and final a value (T optional)
/// we have a list of titles to display for every button
/// Every button has one title inside themap of type string
/// The map also makes sure every key of type string is unique
/// meaning we cannot have buttons  with the same title but have different values
typedef DialogOptionBuilder<T> = Map<String, T?> Function();
Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();

  ///This is defining the alert dialog
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        ///the title heading of the button
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        ///the explanation of the button / body text
        content: Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge,
        ),

        ///Thesea re the actions of the alert dialog
        ///means every key inside the map is an optiontitle
        ///An optionTitle is the title of a button
        actions: options.keys.map((optionTitle) {
          ///get the value of the key
          final T value = options[optionTitle];
          final Color buttonTextColor =
              (value == true) ? kPrimaryColor : kSuccessColor;

          /// every optional tile of type String will be mapped to a textbutton
          return TextButton(
            onPressed: () {
              ///if the value of the map has a value eg true,
              ///return that value
              if (value != null) {
                Navigator.of(context).pop(value);

                ///if the value of the map has nothing eg false,
                ///close the dialog
              } else {
                Navigator.of(context).pop();
              }
            },

            ///the child of the text button is a text of the actual button
            ///(title inside the key value map pair)
            child: Text(
              optionTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: buttonTextColor,
                  ),
            ),
          );
        }).toList(),
      );
    },
  );
}
