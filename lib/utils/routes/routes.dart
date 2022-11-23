import 'package:flutter/material.dart';
import '../../auth/components/firebase_initializer.dart';
import '../../auth/screens/verification/verify_email_screen.dart';
import '../../home/modules/recipes/recipes_screen.dart';
import '../../home/Dashboard/notes_dashboard_screen.dart';
import '../../auth/screens/signin/sign_in_screen.dart';
import '../../auth/screens/signup/signup_screen.dart';
import '../../auth/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  /// Auth routes
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  NotesDashboardScreen.routeName: (context) => const NotesDashboardScreen(),
  RecipesScreen.routeName: (context) => const RecipesScreen(),
  AppInitializer.routeName: (context) => const AppInitializer(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
};
