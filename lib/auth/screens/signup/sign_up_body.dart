import 'package:flutter/material.dart';
import 'sign_up_form.dart';
import 'social_media_signup.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// container holding the login image
          const Upside(
            imgUrl: "assets/images/saves-time-working-with-our-application.svg",
          ),
          const WidgetSeperator(),
          Text(
            textAlign: TextAlign.center,
            "Let's get you an Account",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          ///Form containing log in email details
          const SignUpForm(),

          ///Title bar holding the log in text and social icons
          const SocialMediaSignUp(),
        ],
      ),
    );
  }
}
