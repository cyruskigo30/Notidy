import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    Key? key,
    required this.iconUrl,
    required this.buttonAction,
  }) : super(key: key);
  final String iconUrl;
  final VoidCallback buttonAction;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: buttonAction,
      icon: SvgPicture.asset(
        iconUrl,
      ),
    );
  }
}
