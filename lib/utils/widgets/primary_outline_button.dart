import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onClick,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onClick,
        icon: Icon(
          icon,
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              // color: primaryColor,
              ),
        ),
        style: ElevatedButton.styleFrom(
          side: const BorderSide(
            width: 2.0,
            // color: primaryColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
        ),
      ),
    );
  }
}
