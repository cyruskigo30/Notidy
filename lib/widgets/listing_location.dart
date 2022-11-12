import 'package:flutter/material.dart';

import '../utils/theme/colors.dart';

class ListingLocation extends StatelessWidget {
  const ListingLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          size: 18,
        ),
        Flexible(
          child: Text(
            'Kasarini, Kiambu Road, Nairobi Kenya',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: kDarkTextColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
