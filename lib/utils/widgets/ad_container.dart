import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../theme/colors.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, index) {
          return Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // image: const DecorationImage(

              //   // image: AssetImage('assets/images/slider/propertiesad1.jpg'),
              //   fit: BoxFit.cover,
              // ),
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            height: 150,
            // child:
            //     Image.asset('assets/images/slider/propertiesad1.jpg'),
          );
        },
      ),
    );
  }
}
