import 'package:flutter/material.dart';
import '../../../../utils/theme/colors.dart';

class SplashSlider extends StatelessWidget {
  const SplashSlider({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);
  final String text, image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          'Notidy',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: kPrimaryColor,
                fontSize: 35,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
        ),
        const Spacer(),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
      ],
    );
  }
}


//  