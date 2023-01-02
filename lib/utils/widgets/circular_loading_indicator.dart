import 'package:flutter/material.dart';
import 'package:notidy/utils/constants/constants.dart';
import '../theme/colors.dart';

class CircularLoadingIndicator extends StatelessWidget {
  const CircularLoadingIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMediumHeight),
      child: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
