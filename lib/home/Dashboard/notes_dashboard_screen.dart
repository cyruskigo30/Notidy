import 'package:flutter/material.dart';
import 'package:notidy/services/auth/auth_service.dart';
import 'dart:developer' as app show log;
import '../../auth/screens/splash/splash_screen.dart';
import '../../utils/theme/colors.dart';
import '../../utils/enums/dashboard_menu_action.dart';
import '../../widgets/custom_bottom_navigation.dart';
import 'notes_dashboard_body.dart';
import 'customer_drawer.dart';

class NotesDashboardScreen extends StatefulWidget {
  const NotesDashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/notes_dashboard';

  @override
  State<NotesDashboardScreen> createState() => _NotesDashboardScreenState();
}

class _NotesDashboardScreenState extends State<NotesDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notidy',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.light_mode_outlined,
            ),
          ),
          PopupMenuButton<DashboardActions>(
            onSelected: (value) async {
              app.log('$value');

              ///use the switch case to switch between various dashboard actions
              switch (value) {

                ///Handling the log out case
                case DashboardActions.signout:

                  ///Await the logout dialog that has the options on whether to sign out or stay in the app
                  final shouldLogout = await showLogoutDialog(context);
                  app.log(shouldLogout.toString());

                  ///Actualize the firebase actions when the two options are presented by the showLogout Dialog function
                  if (shouldLogout) {
                    ///if you choose to log out, detach the firebase connection
                    await AuthService.initializeFirebaseAuth().signOut();

                    /// this is just to alleviate dart concern on using navigator after async
                    if (!mounted) return;

                    /// and also send the user out of the app dashboard
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SplashScreen.routeName,
                      (_) => false,
                    );
                  }
                  break;
                default:
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<DashboardActions>(
                  value: DashboardActions.add,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.add),
                    title: Text(
                      'New',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                PopupMenuItem<DashboardActions>(
                  value: DashboardActions.settings,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                PopupMenuItem<DashboardActions>(
                  value: DashboardActions.signout,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.power_settings_new_rounded),
                    title: Text(
                      'Signout',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const MainBody(),
      drawer: const DrawerPage(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

///remember the user doesn't have to use the only options provided by the dialog
///They can use the back button on the phone to exit or even click outside the dialog to close it
///for that reason use then keyword to give the app another route of false which dismissies the pop up
Future<bool> showLogoutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Sign Out',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: kSuccessColor,
                  ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ),
        ],
      );
    },

    ///either the user picks a value from the above provided dialog actions
    ///or the app returns false which dismisses the pop up especially if the user
    ///uses the back button on the phone to exit or even click outside the dialog to close it
  ).then((value) => value ?? false);
}
