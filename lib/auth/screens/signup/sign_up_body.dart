import 'package:flutter/material.dart';
import '../signin/sign_in_screen.dart';
import '../verification/verify_email_screen.dart';
import '../../../services/auth/auth_exceptions.dart';
import '../../../services/auth/auth_service.dart';
import '../../../utils/functions/show_snackbar.dart';
import '../../../utils/theme/colors.dart';
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

                    ///We need to save our user to firebase using the received email and password
                    ///and to do this we use firebase predefined createuserwithemailandpassword function
                    ///if registration is successful, Send the user a verification email
                    ///and also reroute them to the verification email page so that they can manually resend the link
                    ///if they didn't receive it
                    try {
                      await AuthService.initializeFirebaseAuth().createUser(
                        authId: email,
                        authPassword: password,
                      );

                      ///to automatically send the link to email upon successful registration,
                      ///We start by getting the current user
                      // final currentUser =
                      //     AuthService.initializeFirebaseAuth().currentUser;

                      ///Then we use the Firebase inbuilt function for sending user verification
                      await AuthService.initializeFirebaseAuth()
                          .sendEmailVerification();
                      // await currentUser?.sendEmailVerification();

                      ///Use push named to give the user the possibility of going back to registration if they used the wromg email
                      /// this is just to alleviate dart concern on using navigator after async
                      if (!mounted) return;

                      /// We then reroute the user to the verification screen where we notify them of our action
                      /// in which we just sent them the link above
                      /// or give them an option to resend the link if they didn't recieve it

                      Navigator.of(context)
                          .pushNamed(VerifyEmailScreen.routeName);

                      ///If registration didn't happen,
                      ///Let's tell the user why using our custom made global fucntion that displays the reason (Error) in a snackbar
                    } on EmailAlreaadyInUseAuthException {
                      showSnackBar(context, 'Email Address Already in use');
                    } on InvalidEmailAuthException {
                      showSnackBar(context, 'Invalid Email Address');
                    } on WeakPasswordAuthException {
                      showSnackBar(
                          context, 'Weak Passsword, Please try Another');
                    } on UnknownAuthException {
                      showSnackBar(context, 'Ensure all details are provided');
                    } on GenericAuthException {
                      showSnackBar(context, 'Authentication Error');
                    }
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
