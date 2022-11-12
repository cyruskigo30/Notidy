import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    this.suffixIcon,
    required this.textfieldController,
  }) : super(key: key);
  final IconData icon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextEditingController textfieldController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .9,
      child: TextField(
        controller: textfieldController,
        textCapitalization: TextCapitalization.sentences,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: Icon(
            icon,
          ),
          suffixIcon: Icon(suffixIcon),
        ),
      ),
    );
  }
}
