import 'package:flutter/material.dart';
import 'splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routeName = '/splash_screen';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// This ensures the bottom sheet resize error doesnt occur fro
      ///  when the keyboard closes
      resizeToAvoidBottomInset: false,
      body: SplashBody(),
    );
  }
}
