import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          const WidgetSeperator(),

          /// container holding the verify email image

          const Upside(
            imgUrl: "assets/images/signin.svg",
          ),

          const WidgetSeperator(),

          ///Tell the user that we automatially send en email to their address
          ///and they should use it to verify their account
          Text(
            'An email verification link was sent to your email address.',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const WidgetSeperator(),

          ///If they didn't reeive the email,
          ///Give them a button to resend the email  link again
          Row(
            children: [
              Text(
                'Did\'nt Receive it?',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              PrimaryButton(
                icon: Icons.keyboard_arrow_up_outlined,
                text: 'Resend Email',
                onClick: () async {
                  ///first get the current user
                  final appUser = FirebaseAuth.instance.currentUser;

                  ///send user the email verification using the firebase predefined function
                  await appUser?.sendEmailVerification();
                },
              ),
            ],
          ),
          const WidgetSeperator(),
        ],
      ),
    );
  }
}
