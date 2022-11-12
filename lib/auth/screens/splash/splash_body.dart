import 'package:flutter/material.dart';
import '../../../utils/theme/colors.dart';
import '../signin/sign_in_screen.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/secondary_button.dart';
import '../signup/signup_screen.dart';
import 'widgets/splash_slider.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

int currentSlide = 0;

class _SplashBodyState extends State<SplashBody> {
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Notidy, Let's Create some notes",
      "image": "assets/images/slider/notidy.png"
    },
    {
      "text": "Get access to note taking tools",
      "image": "assets/images/slider/notes.png"
    },
    {
      "text": "Create personal notes and reminders",
      "image": "assets/images/slider/personal.png"
    },
    {
      "text": "Create group notes and meeting resolutions",
      "image": "assets/images/slider/group.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(kMediumWidth),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  setState(() {
                    currentSlide = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashSlider(
                  image: "${splashData[index]["image"]}",
                  text: "${splashData[index]["text"]}",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                splashData.length,
                (index) => buildSliderDot(index),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Spacer(),
                  PrimaryButton(
                    icon: Icons.keyboard_arrow_right_rounded,
                    text: 'Sign in',
                    onClick: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                  ),
                  const Spacer(),
                  SecondaryButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    text: 'Sign up',
                    onClick: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///Slider dots indicators
  AnimatedContainer buildSliderDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: kMediumHeight,
      width: currentSlide == index ? 20 : kMediumWidth,
      margin: const EdgeInsets.only(right: kSmallWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: currentSlide == index ? kPrimaryColor : kCardDarkColor,
      ),
    );
  }
}
