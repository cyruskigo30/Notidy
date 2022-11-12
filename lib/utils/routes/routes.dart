import 'package:flutter/material.dart';
import '../../home/modules/recipes/recipes_screen.dart';
import '../../home/Dashboard/main_dashboard.dart';
import '../../auth/screens/signin/sign_in_screen.dart';
import '../../auth/screens/signup/signup_screen.dart';
import '../../auth/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> routes = {
  /// Auth routes
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  MainDashboard.routeName: (context) => const MainDashboard(),

  RecipesScreen.routeName: (context) => const RecipesScreen(),
};
