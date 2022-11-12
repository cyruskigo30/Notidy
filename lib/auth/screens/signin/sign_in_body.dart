import 'package:flutter/material.dart';
import '../../../home/Dashboard/main_dashboard.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/theme/colors.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/widget_seperator.dart';
import '../../components/upside.dart';
import '../../components/title_bar.dart';
import '../signup/signup_screen.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
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
              icon: Icons.email_outlined,
              labelText: 'Email Address',
              hintText: 'Enter your email address',
              obscureText: false,
              textfieldController: emailController,
            ),
            const WidgetSeperator(),

            ///Password textfield
            CustomInputField(
              icon: Icons.lock_outlined,
              labelText: 'Password',
              hintText: 'Enter your password',
              suffixIcon: Icons.visibility_outlined,
              obscureText: true,
              textfieldController: passwordController,
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
                  onClick: () {
                    Navigator.pushNamed(context, MainDashboard.routeName);
                  }),
            ),
            const WidgetSeperator(),

            /// Forgot password
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: kDefaultScreenMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                    child: Text(
                        textAlign: TextAlign.end,
                        'No Account ? Sign Up',
                        style: Theme.of(context).textTheme.bodyLarge),
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
