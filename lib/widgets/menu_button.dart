import 'package:flutter/material.dart';
import 'package:notidy/utils/constants/constants.dart';
import '../utils/theme/colors.dart';
import 'package:flutter_svg/svg.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.imageUrl,
    required this.buttonText,
    this.imageHeight,
    required this.onClick,
    required this.buttonColor,
  }) : super(key: key);
  final String imageUrl;
  final String buttonText;
  final double? imageHeight;
  final Color buttonColor;
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
        child: Column(
          children: [
            Card(
              // elevation: kDefaultElevation,
              color: buttonColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: buttonColor,
                ),
                borderRadius: BorderRadius.circular(kDefaultRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  imageUrl,
                  color: kDarkTextColor,
                  width: 35,
                ),
              ),
            ),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
