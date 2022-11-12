import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.buttonImage,
    required this.buttonText,
    this.imageHeight,
    required this.onClick,
  }) : super(key: key);
  final String buttonImage;
  final String buttonText;
  final double? imageHeight;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(
            // horizontal: kSmallWidth,
            // vertical: kSmallHeight,
            ),
        child: Card(
          child: Stack(
            children: [
              Positioned(
                left: kSmallWidth,
                top: kSmallHeight,
                child: Text(
                  buttonText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Positioned(
                right: kSmallWidth,
                bottom: kSmallHeight,
                child: Image.asset(
                  buttonImage,
                  height: 70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
