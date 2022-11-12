import 'package:flutter/material.dart';
import '../../../widgets/primary_button.dart';
import '../signin/sign_in_screen.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/widget_Seperator.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(kDefaultScreenMargin),
      child: Form(
        child: Column(
          children: [
            ///Email address text field
            const CustomInputField(
              icon: Icons.person_outline_outlined,
              labelText: 'User Name',
              hintText: 'Enter your user name',
              obscureText: false,
            ),
            const WidgetSeperator(),
            const CustomInputField(
              icon: Icons.email_outlined,
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              obscureText: false,
            ),
            const WidgetSeperator(),

            ///Password textfield
            const CustomInputField(
              icon: Icons.lock_outlined,
              labelText: 'Password',
              hintText: 'Enter your password',
              suffixIcon: Icons.visibility_outlined,
              obscureText: true,
            ),
            const WidgetSeperator(),

            ///Password textfield
            const CustomInputField(
              icon: Icons.lock_outlined,
              labelText: 'Confirm Password',
              hintText: 'Enter your password',
              suffixIcon: Icons.visibility_outlined,
              obscureText: true,
            ),

            const WidgetSeperator(),

            /// Sign in Button
            PrimaryButton(
                icon: Icons.keyboard_arrow_up_outlined,
                text: 'Sign Up',
                onClick: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
