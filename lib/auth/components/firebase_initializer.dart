import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notidy/auth/screens/signin/sign_in_body.dart';
import 'package:notidy/auth/screens/signin/sign_in_screen.dart';
import 'package:notidy/auth/screens/verification/verify_email_screen.dart';
import 'package:notidy/firebase_options.dart';

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
            return SignInScreen();
          // ///if the appUser?.emailVerified exists take it if not take the false
          // // final emailVerified = appUser?.emailVerified ?? false;
          // if (appUser?.emailVerified ?? false) {
          //   ///Go to login page
          //   return const SignInBody();
          // } else {
          //   ///Go to email verification screen
          //   return const VerifyEmailScreen();
          // }

          ///otherwise if firebase  connection isn't established for one reason or another
          ///including maybe network connection, then show the user that the app is loading
          default:
            return const Text('Loading ....');
        }
      },
    );
  }
}
