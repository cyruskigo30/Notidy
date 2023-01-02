import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants/constants.dart';

class Upside extends StatelessWidget {
  const Upside({
    super.key,
    required this.imgUrl,
  });
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height / 4.5,
          // color: kBlackBlueColor,
          child: Padding(
            padding: const EdgeInsets.only(
              top: kMediumHeight,
            ),
            child: SvgPicture.asset(imgUrl),
          ),
        ),
        Positioned(
          left: 20,
          top: 25,
          child: Image.network(
            'https://cdn-icons-png.flaticon.com/128/414/414927.png',
            scale: 3,
          ),
        ),
        Positioned(
          right: 20,
          top: 25,
          child: Image.network(
            'https://cdn-icons-png.flaticon.com/128/414/414927.png',
            scale: 2,
          ),
        ),
      ],
    );
  }
}
