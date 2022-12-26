import 'package:flutter/material.dart';
import '../utils/theme/colors.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
            semanticsLabel: 'loading',
          ),
        ),
      ),
    );
  }
}
