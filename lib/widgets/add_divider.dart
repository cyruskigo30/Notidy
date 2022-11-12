import 'package:flutter/material.dart';
import '../utils/theme/colors.dart';

class AddDivider extends StatelessWidget {
  const AddDivider({
    Key? key,
    this.thickness = .5,
  }) : super(key: key);
  final double? thickness;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      color: kDarkTextColor,
    );
  }
}
