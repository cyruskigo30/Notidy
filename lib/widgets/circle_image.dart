import 'package:flutter/material.dart';
import '../utils/theme/colors.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({
    Key? key,
    this.circleRadius = 20,
    this.imageProvider,
  }) : super(key: key);

  ///CircleImage has two parameters imageProvider and circleRadius
  ///ImageProvider identifies the image without committing to the precise final asset
  final ImageProvider? imageProvider;
  final double circleRadius;
  @override
  Widget build(BuildContext context) {
    ///CircleAvatar is a widget of the material library
    ///We create two circles one inside the other
    ///The first is the outer circle with a primary color as background
    ///and a radius of circleRadius
    return CircleAvatar(
      backgroundColor: kLightTextColor,
      radius: circleRadius,

      ///The second circle holds the image with the help of the provider
      ///it's radius is 5 pixels less that the parent circle
      ///leaving a primary colored border around the image effect
      child: CircleAvatar(
        radius: circleRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
