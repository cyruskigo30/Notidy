import 'package:flutter/material.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../signin/sign_in_screen.dart';
import 'social_media_signup.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
          Container(
            margin: const EdgeInsets.all(kDefaultScreenMargin),
            child: Column(
              children: [
                ///Email address text field
                const WidgetSeperator(),
                CustomInputField(
                  textfieldController: emailController,
                  icon: Icons.email_outlined,
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  obscureText: false,
                ),
                const WidgetSeperator(),

                ///Password textfield
                CustomInputField(
                  textfieldController: passwordController,
                  icon: Icons.lock_outlined,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: Icons.visibility_outlined,
                  obscureText: true,
                ),
                const WidgetSeperator(),

                const WidgetSeperator(),

                /// Sign up Button
                PrimaryButton(
                  icon: Icons.keyboard_arrow_up_outlined,
                  text: 'Sign Up',
                  onClick: () async {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  },
                ),
              ],
            ),
          ),

          ///Title bar holding the log in text and social icons
          const SocialMediaSignUp(),
        ],
      ),
    );
  }
}
