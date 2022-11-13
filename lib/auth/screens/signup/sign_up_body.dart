import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../signin/sign_in_screen.dart';
import 'social_media_signup.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  ///create text controllers that receive the user entered text
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ///initializing the state that allows the reception of this data
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  ///after initializing them, they must also be disposed once used
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          Container(
            margin: const EdgeInsets.all(kDefaultScreenMargin),
            child: Column(
              children: [
                ///Email address text field
                const WidgetSeperator(),
                CustomInputField(
                  textfieldController: _emailController,
                  icon: Icons.email_outlined,
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const WidgetSeperator(),

                ///Password textfield
                CustomInputField(
                  keyboardType: TextInputType.visiblePassword,
                  textfieldController: _passwordController,
                  icon: Icons.lock_outlined,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: Icons.visibility_outlined,
                  obscureText: true,
                ),
                const WidgetSeperator(),

                /// Sign up Button
                PrimaryButton(
                  icon: Icons.keyboard_arrow_up_outlined,
                  text: 'Sign Up',
                  onClick: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final UserCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    log('$UserCredential');
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
