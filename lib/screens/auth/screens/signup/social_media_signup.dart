import 'package:flutter/material.dart';
import '../../../../utils/widgets/svg_icon_button.dart';
import '../signin/sign_in_screen.dart';

class SocialMediaSignUp extends StatelessWidget {
  const SocialMediaSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: MediaQuery.of(context).size.height / 6,
      decoration: const BoxDecoration(
        // color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'or use',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                iconUrl: 'assets/images/facebook-svgrepo-com.svg',
              ),
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                iconUrl: 'assets/images/google-svgrepo-com.svg',
              ),
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                iconUrl: 'assets/images/twitter-svgrepo-com.svg',
              ),
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
                iconUrl: 'assets/images/telephone-call-svgrepo-com.svg',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
