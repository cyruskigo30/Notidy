import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notidy/auth/screens/signin/sign_in_screen.dart';
import 'package:notidy/auth/screens/splash/splash_screen.dart';
import 'package:notidy/auth/screens/verification/verify_email_screen.dart';
import 'package:notidy/firebase_options.dart';
import 'package:notidy/home/Dashboard/notes_dashboard_screen.dart';
import 'package:notidy/utils/theme/colors.dart';

class AppInitializer extends StatelessWidget {
  const AppInitializer({super.key});
  static String routeName = '/App_initializer';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {

          ///If firebase connection is successfully estbalished then direct user based on their state
          case ConnectionState.done:
            final appUser = FirebaseAuth.instance.currentUser;
            log("$appUser");

            ///Check if user exists
            if (appUser != null) {
              ///if user exists and email is verified send them to dashboard
              if (appUser.emailVerified) {
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
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                    semanticsLabel: 'loading',
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}
