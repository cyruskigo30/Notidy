import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notidy/auth/components/firebase_initializer.dart';
import 'package:notidy/auth/screens/verification/verify_email_screen.dart';
import 'package:notidy/home/Dashboard/notes_dashboard_screen.dart';
import 'package:notidy/utils/functions/show_snackbar.dart';
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

                    ///before taking the user to the dashbaord,check if they are verified
                    ///by first getting their credentials
                    final appuser = FirebaseAuth.instance.currentUser;

                    if (appuser?.emailVerified ?? false) {
                      /// if they are verified send them to the dashboard
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          NotesDashboardScreen.routeName, (route) => false);
                    } else {
                      ///  otherwise send them to the verify email screen
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          VerifyEmailScreen.routeName, (route) => false);
                    }

                    ///If it fails tell the user why their attempt to sign in failed
                  } on FirebaseAuthException catch (error) {
                    if (error.code == 'user-not-found') {
                      showSnackBar(context, 'Error!!  User Account Not Found');
                    } else if (error.code == 'wrong-password') {
                      showSnackBar(context, 'Wrong Account Password');
                    } else if (error.code == 'invalid-email') {
                      showSnackBar(context, 'Invalid Email Address');
                    } else if (error.code == 'unknown') {
                      showSnackBar(context, 'Ensure all details are provided');

                      ///Other firebase auth errors that we may not know will be displayed by this else
                    } else {
                      showSnackBar(context, 'Error!! ${error.code}');
                    }

                    ///when the error has nothing to do with firebase but another kinds of exceptions
                  } catch (error) {
                    showSnackBar(context, 'Error : ${error.toString()}');
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
