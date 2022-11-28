import 'package:flutter/material.dart';
import 'package:notidy/auth/screens/verification/verify_emial_body.dart';
import 'package:notidy/utils/constants/constants.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);
  static String routeName = '/verify_email_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verify Email',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kMediumWidth,
        ),
        child: Center(
          child: const VerifyEmailBody(),
        ),
      ),
    );
  }
}
