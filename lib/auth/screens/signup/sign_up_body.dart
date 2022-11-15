import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notidy/firebase_options.dart';
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

            /// This future will process first its future (Firebase Initialization) before the Ui is built
            child: FutureBuilder(
              ///First initialie the firebase
              future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),

              ///Then build the UI Based on the results of the call back
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {

                  ///other case scenarios
                  // case ConnectionState.none:
                  //   // TODO: Handle this case.
                  //   break;
                  // case ConnectionState.waiting:
                  //   // TODO: Handle this case.
                  //   break;
                  // case ConnectionState.active:
                  //   // TODO: Handle this case.
                  //   break;
                  ///when the connection state is done return the UI
                  case ConnectionState.done:
                    return Column(
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

                            ///Initialize firebase to be ready to receive the content
                            ///Assign the firebase assigned default credentials variable  (UserCredential) to the received variables
                            final UserCredential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            log('$UserCredential');

                            ///if registration is successful, Send the user to the sign in page otherwise show error
                            // Navigator.pushNamed(
                            //     context, SignInScreen.routeName);
                          },
                        ),
                      ],
                    );

                  ///Default stands for any other possible case since they all return the same output
                  ///so if the users connection is too slow it'll display that
                  default:
                    return const Text('Loading ....');
                }
              },
            ),
          ),

          ///Title bar holding the log in text and social icons
          const SocialMediaSignUp(),
        ],
      ),
    );
  }
}
