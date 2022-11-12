import 'package:flutter/material.dart';
import '../../home/Dashboard/main_dashboard.dart';
import '../../widgets/svg_icon_button.dart';

class AuthTitleBar extends StatelessWidget {
  const AuthTitleBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 6,
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
            textAlign: TextAlign.center,
            "Login to your Account",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, MainDashboard.routeName);
                },
                iconUrl: 'assets/images/facebook-svgrepo-com.svg',
              ),
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, MainDashboard.routeName);
                },
                iconUrl: 'assets/images/google-svgrepo-com.svg',
              ),
              SvgIconButton(
                buttonAction: () {
                  Navigator.pushNamed(context, MainDashboard.routeName);
                },
                iconUrl: 'assets/images/twitter-svgrepo-com.svg',
              ),
            ],
          ),
          Text(
            'or use your Email Address',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
