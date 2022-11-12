import 'package:flutter/material.dart';
import '../../../models/recipe_model.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/theme/colors.dart';
import '../../../widgets/widget_seperator.dart';
import '../../../widgets/custom_bottom_navigation.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({
    Key? key,
    required this.recipeObject,
  }) : super(key: key);

  /// Create an object of the recipe
  final Recipe recipeObject;

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  int _sliderVal = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeObject.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kMediumWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const WidgetSeperator(),
                SizedBox(
                  height: 300,
                  width: double.infinity,

                  ///display the recipe Image
                  child: Image(
                    image: AssetImage(widget.recipeObject.imageUrl),
                  ),
                ),
                const SizedBox(
                  height: kMediumHeight,
                ),

                ///Display the recipe title
                Text(
                  widget.recipeObject.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const WidgetSeperator(),

                ///Display the ingredients
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.recipeObject.ingredients.length,
                  itemBuilder: (BuildContext context, int index) {
                    final ingedientObject =
                        widget.recipeObject.ingredients[index];
                    //todo add ingredient qty
                    return Text(
                      '${ingedientObject.ingredientQuantity * _sliderVal} '
                      '${ingedientObject.ingredientMeasure} '
                      '${ingedientObject.ingredientName} ',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  },
                ),

                /// display servings slider here
                /// slider hels update the recipe quantities based on the number of
                /// people to be served (Servings) which are sdjusted by the slider
                Slider(
                  min: 1,
                  max: 10,
                  divisions: 9,
                  label:
                      '${_sliderVal * widget.recipeObject.servings} Servings',
                  value: _sliderVal.toDouble(),
                  onChanged: (newValue) {
                    setState(() {
                      _sliderVal = newValue.round();
                    });
                  },
                  activeColor: kPrimaryColor,
                  inactiveColor: Theme.of(context).cardColor,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
