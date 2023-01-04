import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/constants.dart';
import '../theme/colors.dart';

class AdContainer extends StatelessWidget {
  const AdContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kMediumWidth,
        vertical: kMediumHeight,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        image: const DecorationImage(
          image: AssetImage('assets/brandimages/chartbg.png'),
          fit: BoxFit.cover,
          opacity: .08,
        ),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      height: 170,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best Mobile Application for',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: kDarkTextColor),
              ),
              Text(
                'NOTE TAKING',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: kDarkTextColor),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(
                    color: kDarkTextColor,
                    width: 1,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                ),
                label: Text(
                  'Share App',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: kPrimaryColor),
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            'assets/svg/notes-notebook-svgrepo-com.svg',
            height: 130,
            color: kDarkTextColor.withOpacity(.2),
          ),
        ],
      ),
    );
  }
}
