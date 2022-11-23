import 'package:flutter/material.dart';
import '../../widgets/widget_seperator.dart';
import '../../widgets/ad_container.dart';
import '../../widgets/search_bar.dart';
import '../../utils/constants/constants.dart';

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kMediumWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WidgetSeperator(),
              Text(
                "Let's help you find your next",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: kSmallHeight,
              ),
              Text(
                "Meal",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const WidgetSeperator(),
              const SearchBar(),
              const WidgetSeperator(),
              const AdContainer(),
              const WidgetSeperator(),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                children: const [
                  // MenuButton(
                  //   buttonText: 'Recipes',
                  //   buttonImage: 'assets/images/slider/recipe.png',
                  //   onClick: () {
                  //     Navigator.pushNamed(context, RecipesScreen.routeName);
                  //   },
                  // ),
                  // MenuButton(
                  //   buttonText: 'Kitchenware',
                  //   buttonImage: 'assets/images/slider/home-appliance.png',
                  //   onClick: () {
                  //     // Navigator.pushNamed(context, MachineryScreen.routeName);
                  //   },
                  // ),
                  // MenuButton(
                  //   buttonText: 'Cookbooks',
                  //   buttonImage: 'assets/images/slider/recipebook.png',
                  //   onClick: () {
                  //     Navigator.pushNamed(context, RecipesScreen.routeName);
                  //   },
                  // ),
                  // MenuButton(
                  //   buttonText: 'Utensils',
                  //   buttonImage: 'assets/images/slider/culinary_sets.png',
                  //   onClick: () {
                  //     // Navigator.pushNamed(context, MachineryScreen.routeName);
                  //   },
                  // ),
                  // MenuButton(
                  //   buttonText: 'Catering',
                  //   buttonImage: 'assets/images/slider/buffet.png',
                  //   onClick: () {
                  //     Navigator.pushNamed(context, RecipesScreen.routeName);
                  //   },
                  // ),
                  // MenuButton(
                  //   buttonText: 'Events',
                  //   buttonImage: 'assets/images/slider/party.png',
                  //   onClick: () {
                  //     // Navigator.pushNamed(context, MachineryScreen.routeName);
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
