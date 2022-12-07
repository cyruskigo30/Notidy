import 'package:flutter/material.dart';
import 'package:notidy/services/auth/auth_service.dart';
import '../splash/splash_screen.dart';
import '../../../utils/theme/colors.dart';
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

          const SizedBox(height: 40),

          ///Tell the user that we automatially send en email to their address
          ///and they should use it to verify their account
          Text(
            'An email verification link was sent to your email address.',
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),
          Text(
            'Also check your Spam folder if not in your inbox.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kPrimaryColor,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Text(
            'Not Received ?,  Click resend below',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          ///If they didn't reeive the email,
          ///Give them a button to resend the email  link again
          PrimaryButton(
            icon: Icons.keyboard_arrow_up_outlined,
            text: 'Resend  Email',
            onClick: () async {
              ///send user the email verification
              await AuthService.initializeFirebaseAuth()
                  .sendEmailVerification();
            },
          ),
          const SizedBox(height: 40),
          Text(
            'or',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          /// Remember this user is already registred but doen't have an account
          /// we can give the user the option to leave this accout all together

          TextButton.icon(
            onPressed: () async {
              /// specifically to detach with firebase, which automatically updates phone cache
              await AuthService.initializeFirebaseAuth().signOut();

              /// this is just to alleviate dart concern on using navigator after async
              if (!mounted) return;

              /// Send the user to the beginning of the app
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SplashScreen.routeName, (route) => false);
            },
            icon: Icon(
              Icons.close_outlined,
              color: kPrimaryColor,
            ),
            label: Text(
              'Log Off',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: kPrimaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
