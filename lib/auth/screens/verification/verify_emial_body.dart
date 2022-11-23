import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notidy/auth/screens/signin/sign_in_screen.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';

class VerifyEmailBody extends StatefulWidget {
  const VerifyEmailBody({Key? key}) : super(key: key);

  @override
  State<VerifyEmailBody> createState() => _VerifyEmailBodyState();
}

class _VerifyEmailBodyState extends State<VerifyEmailBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// container holding the login image
          const Upside(
            imgUrl: "assets/images/signin.svg",
          ),

          const WidgetSeperator(),
          Text(
            'Click to Verify email',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const WidgetSeperator(),
          Text(
            'An email verification link will be sent to your email address.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const WidgetSeperator(),

          /// Sign in Button
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: kDefaultScreenMargin),
            child: PrimaryButton(
              icon: Icons.keyboard_arrow_up_outlined,
              text: 'Verify Email',
              onClick: () async {
                ///first get the current user
                final appUser = FirebaseAuth.instance.currentUser;
                log('${appUser?.email}');

                ///send user the email verification using the firebase predefined function
                await appUser?.sendEmailVerification();
              },
            ),
          ),
          const WidgetSeperator(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
            child: Text('Already verified?'),
          ),
        ],
      ),
    );
  }
}