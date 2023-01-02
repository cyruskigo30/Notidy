import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onClick,
        icon: Icon(
          icon,
        ),
        label: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
              ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: kDefaultElevation,
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultRadius),
          ),
        ),
      ),
    );
  }
}
