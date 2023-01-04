import 'package:flutter/material.dart';
import '../../screens/home/all_notes_view.dart';
import '../../screens/home/create_update_note_view.dart';
import '../../screens/auth/components/app_initializer.dart';
import '../../screens/auth/screens/verification/verify_email_screen.dart';
import '../../screens/auth/screens/signin/sign_in_screen.dart';
import '../../screens/auth/screens/signup/signup_screen.dart';
import '../../screens/auth/screens/splash/splash_screen.dart';
import '../../screens/home/notes_dashboard_screen.dart';

final Map<String, WidgetBuilder> routes = {
  /// Auth routes
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  NotesDashboardScreen.routeName: (context) => const NotesDashboardScreen(),
  AppInitializer.routeName: (context) => const AppInitializer(),
  VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
  CreateUpdateNoteScreen.routeName: (context) => const CreateUpdateNoteScreen(),
  AllNotesView.routeName: (context) => const AllNotesView(),
};
