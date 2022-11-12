import 'package:flutter/material.dart';
import '../../components/sign_in_form.dart';
import '../../components/upside.dart';
import '../../components/title_bar.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            /// container holding the login image
            Upside(
              imgUrl: "assets/images/signin.svg",
            ),

            ///Title bar holding the log in text and social icons
            AuthTitleBar(),

            ///Form containing log in email details
            SignInForm(),
          ],
        ),
      ),
    );
  }
}
