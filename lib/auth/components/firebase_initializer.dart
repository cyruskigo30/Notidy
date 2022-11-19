import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notidy/auth/screens/signin/sign_in_screen.dart';
import 'package:notidy/auth/screens/splash/splash_screen.dart';
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
            log('Firebase successfully initialized');

            log('${FirebaseAuth.instance.currentUser}');
            final appUser = FirebaseAuth.instance.currentUser;

            ///if the appUser?.emailVerified exists take it if not take the false
            final emailVerified = appUser?.emailVerified ?? false;
            if (emailVerified) {
              ///Go to login page
              log('You are a verified User');
              return const SignInScreen();
            } else {
              log('Please Verify your account first to proceed');

              ///Go to email verification screen
            }
            return const SplashScreen();

          ///otherwise if firebase  connection isn't established for one reason or another
          ///including maybe network connection, then show the user that the app is loading
          default:
            return const Center(
              child: Text('Loading ....'),
            );
        }
      },
    );
  }
}
