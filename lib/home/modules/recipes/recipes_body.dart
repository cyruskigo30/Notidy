import 'package:flutter/material.dart';
import 'recipe_details_screen.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../widgets/ad_container.dart';
import '../../../widgets/search_bar.dart';
import '../../../widgets/widget_seperator.dart';

class RecipesBody extends StatefulWidget {
  const RecipesBody({Key? key}) : super(key: key);

  @override
  State<RecipesBody> createState() => _RecipesBodyState();
}

class _RecipesBodyState extends State<RecipesBody> {
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
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Recipe.samples.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              ///in the details screen point to the details of a single recipe
                              return RecipeDetailsScreen(
                                ///the object links with the details screen
                                recipeObject: Recipe.samples[index],
                              );
                            },
                          ),
                        );
                      },
                      child: buildRecipeCard(index),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRecipeCard(int index) {
    return Card(
      elevation: kDefaultElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(kDefaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kLargeWidth),
        child: Column(
          children: [
            Image(
              image: AssetImage(Recipe.samples[index].imageUrl),
            ),
            const SizedBox(
              height: kLargeHeight,
            ),
            Text(
              Recipe.samples[index].title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
