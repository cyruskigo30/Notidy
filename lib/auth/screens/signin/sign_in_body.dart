import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/theme/colors.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';
import '../../components/title_bar.dart';
import '../signup/signup_screen.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  ///Create variables to hold received signin details
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ///Initialize the state of receiving the info
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
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// container holding the login image
            const Upside(
              imgUrl: "assets/images/signin.svg",
            ),

            ///Title bar holding the log in text and social icons
            const AuthTitleBar(),

            ///Form containing log in email details
            CustomInputField(
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email_outlined,
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              obscureText: false,
              textfieldController: _emailController,
            ),
            const WidgetSeperator(),

            ///Password textfield
            CustomInputField(
              icon: Icons.lock_outlined,
              labelText: 'Password',
              hintText: 'Enter your password',
              suffixIcon: Icons.visibility_outlined,
              obscureText: true,
              textfieldController: _passwordController,
              keyboardType: TextInputType.visiblePassword,
            ),

            /// Remember me feature
            SwitchListTile(
              value: true,
              activeColor: kPrimaryColor,
              onChanged: (val) {},
              dense: true,
              title: Text(
                'Remember me',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const WidgetSeperator(),

            /// Sign in Button
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: kDefaultScreenMargin),
              child: PrimaryButton(
                icon: Icons.keyboard_arrow_up_outlined,
                text: 'Sign In',
                onClick: () async {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  try {
                    final UserCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                  } on FirebaseAuthException catch (e) {
                    log(e.code);
                    if (e.code == 'user-not-found') {
                      log('User Account Not Found');
                    } else if (e.code == 'wrong-password') {
                      log('Wrong Account Password');
                    } else if (e.code == 'invalid-email') {
                      log('Incalid Email Address');
                    }
                  }

                  // Navigator.pushNamed(context, MainDashboard.routeName);
                },
              ),
            ),
            const WidgetSeperator(),

            /// Forgot password
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: kDefaultScreenMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not Registered?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          SignUpScreen.routeName,
                          (route) => false,
                        ),
                        // onPressed: (() => Navigator.pushNamed(
                        //       context,
                        //       SignUpScreen.routeName,
                        //     )),
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: kPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      textAlign: TextAlign.end,
                      'Forgot Password?',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
