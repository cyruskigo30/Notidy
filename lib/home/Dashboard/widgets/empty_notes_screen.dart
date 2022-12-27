import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/theme/colors.dart';
import '../../../widgets/widget_seperator.dart';
import '../quickactions/new_note_screen.dart';

class EmptyNotesScreen extends StatelessWidget {
  const EmptyNotesScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kMediumHeight),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Notidy",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const WidgetSeperator(),
                Text(
                  "You currently have no saved notes",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const WidgetSeperator(),
                SvgPicture.asset(
                  'assets/svg/search-magnifier-magnifying-emoji-no-results-svgrepo-com.svg',
                  height: 150,
                  color: kPrimaryColor,
                ),
                const WidgetSeperator(),
                Text(
                  "Click the button below to create your first note",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const WidgetSeperator(),
                TextButton.icon(
                  onPressed: (() =>
                      Navigator.pushNamed(context, NewNoteScreen.routeName)),
                  icon: Icon(
                    Icons.add,
                    color: kPrimaryColor,
                  ),
                  label: Text(
                    'Create First Note',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      width: 1.0,
                      color: kPrimaryColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kDefaultRadius),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
