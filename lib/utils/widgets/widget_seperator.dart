import 'package:flutter/material.dart';

import '../constants/constants.dart';

class WidgetSeperator extends StatelessWidget {
  const WidgetSeperator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: kDefaultWidgetSpacing,
    );
  }
}
