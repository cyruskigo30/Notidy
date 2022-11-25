import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notidy/home/Dashboard/notes_dashboard_screen.dart';
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
                    ///Try getting the user signed into the firebase DB using their email and password
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    /// this is just to alleviate dart concern on using navigator after async
                    if (!mounted) return;

                    /// If successful send th euser to the dashboard
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        NotesDashboardScreen.routeName, (route) => false);

                    ///If it fails tell the user why their attempt to sign in failed
                  } on FirebaseAuthException catch (error) {
                    log(error.code);
                    if (error.code == 'user-not-found') {
                      log('User Account Not Found');
                      ScaffoldMessenger.of(context).showSnackBar(
                        ///display error using a snackbar
                        const SnackBar(
                          content: Text('Error!!  User Account Not Found'),
                        ),
                      );

                      ///Display error using an alert dialog
                      showErrorDialog(context, 'User Account Not Found');
                    } else if (error.code == 'wrong-password') {
                      log('Wrong Account Password');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Wrong Account Password'),
                        ),
                      );
                    } else if (error.code == 'invalid-email') {
                      log('Invalid Email Address');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Email Address'),
                        ),
                      );
                    } else if (error.code == 'unknown') {
                      log('Ensure all details are provided');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Ensure all details are provided'),
                        ),
                      );

                      ///Other firebase auth errors that we may not know will be displayed by this else
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error!! ${error.code}'),
                        ),
                      );
                    }

                    ///when the error has nothing to do with firebase but another kinds of exceptions
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error : ${error.toString()}'),
                      ),
                    );
                  }
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

///We need a function that displays all the possible auth errors to the user
///when they try to sign in
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Error ! !',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: [
          TextButton(
            ///dismiss the pop up
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'ok',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      );
    },
  );
}
