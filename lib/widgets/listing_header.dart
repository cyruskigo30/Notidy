import 'package:flutter/material.dart';
import 'ad_container.dart';
import 'search_bar.dart';
import 'widget_seperator.dart';
import '../utils/constants/constants.dart';

class ListingHeader extends StatelessWidget {
  const ListingHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const WidgetSeperator(),
        Text(
          "Let's help you find your next",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: kMediumHeight,
        ),
        Text(
          "Apartment",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const WidgetSeperator(),
        const SearchBar(),
        const WidgetSeperator(),
        const AdContainer(),
      ],
    );
  }
}
