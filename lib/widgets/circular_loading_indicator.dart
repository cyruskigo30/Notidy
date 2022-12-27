import 'package:flutter/material.dart';
import 'package:notidy/utils/constants/constants.dart';
import '../utils/theme/colors.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kMediumHeight),
          child: Center(
            child: CircularProgressIndicator(
              color: kPrimaryColor,
              semanticsLabel: 'loading',
            ),
          ),
        ),
      ),
    );
  }
}
