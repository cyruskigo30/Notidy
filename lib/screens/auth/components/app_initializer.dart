///This file runs as soon as the app is opened
///inorder to start the process of initializing firebase
import 'package:flutter/material.dart';
import '../../home/notes_dashboard_screen.dart';
import '../../../utils/widgets/circular_loading_indicator.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/verification/verify_email_screen.dart';
import '../../../services/auth/auth_service.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});
  static String routeName = '/App_initializer';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      ///the UI tells the auth service to initialize the firebase_auth file
      /// then call the intializeFirebase function
      /// whose purpose is to intialize firebase using the inbuilt Firebase.initializeAppp function.
      future: AuthService.initializeFirebaseAuth().initializeFirebase(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {

          ///If firebase connection is successfully estbalished then direct user based on their state
          case ConnectionState.done:

            ///to get the current user status, the UI tells the auth service to initialize the firebase_auth file
            /// then call the getter method currentUser which uses the Firebase inbuilt method  FirebaseAuth.instance.currentUser to get the user from firebase

            final appUser = AuthService.initializeFirebaseAuth().currentUser;

            ///Check if user exists
            if (appUser != null) {
              ///if user exists and email is verified send them to dashboard
              if (appUser.isEmailVerified) {
                return const NotesDashboardScreen();

                ///if the user exists but haven't verified their email send them to the verify email screen
              } else {
                return const VerifyEmailScreen();
              }

              ///if the user doesn't exist send them to the splash screen
            } else {
              return const SplashScreen();
            }

          ///otherwise if firebase  connection isn't established for one reason or another
          ///including maybe network connection, then show the user that the app is loading
          default:
            return const CircularLoadingIndicator();
        }
      },
    );
  }
}
