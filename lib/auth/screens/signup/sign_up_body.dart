import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notidy/auth/screens/signin/sign_in_screen.dart';
import 'package:notidy/utils/theme/colors.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/primary_button.dart';
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
                    //Assign the received credentials to new ones to be sent to firebase
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    ///Assign the firebase assigned default credentials variable  (UserCredential) to the received variables
                    try {
                      final UserCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                    } on FirebaseAuthException catch (e) {
                      // log(e.code);
                      if (e.code == 'email-already-in-use') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email Address Already in use'),
                          ),
                        );
                      } else if (e.code == 'invalid-email') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid Email Address'),
                          ),
                        );
                      } else if (e.code == 'weak-password') {
                        log('Weak Passsword, Please try Another');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Weak Passsword, Please try Another'),
                          ),
                        );
                      } else if (e.code == 'unknown') {
                        log('Ensure all details are provided');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ensure all details are provided'),
                          ),
                        );
                      }
                    }

                    ///if registration is successful, Send the user to the sign in page otherwise show error
                    // Navigator.pushNamed(
                    //     context, SignInScreen.routeName);
                  },
                ),
              ],
            ),
          ),

          ///Title bar holding the log in text and social icons
          const SocialMediaSignUp(),
          const WidgetSeperator(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already ahve an account?',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  SignInScreen.routeName,
                  (route) => false,
                ),
                child: Text(
                  'Sign in',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
