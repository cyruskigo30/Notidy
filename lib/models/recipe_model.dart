class Recipe {
  ///class properties
  String title;
  String imageUrl;
  int servings;
  List<Ingredient> ingredients;

  ///constructor
  Recipe(
    this.title,
    this.imageUrl,
    this.servings,
    this.ingredients,
  );

  ///Recipe list
  static List<Recipe> samples = [
    Recipe(
      'Spaghetti and Meatballs',
      'assets/images/food_pics/spaghetti.png',
      3,
      [
        Ingredient(1, 'Box', 'Spaghetti'),
        Ingredient(4, '', 'Frozen Meatballs'),
        Ingredient(0.5, 'Jar', 'Sauce'),
      ],
    ),
    Recipe(
      'Hawaiian Pizza',
      'assets/images/food_pics/pizza.png',
      4,
      [
        Ingredient(1, 'Item', 'Pizza'),
        Ingredient(1, 'Cup', 'Pineapple'),
        Ingredient(8, 'Oz', 'Ham'),
      ],
    ),
    Recipe(
      'Fried Chicken',
      'assets/images/food_pics/fried-chicken.png',
      7,
      [
        Ingredient(1, 'Full', 'Chicken'),
        Ingredient(3, 'Tea Spoons', 'Salt'),
        Ingredient(0.5, 'Jar', 'Sauce'),
      ],
    ),
    Recipe(
      'Chocolate Chip Cookies',
      'assets/images/food_pics/cookies.png',
      8,
      [
        Ingredient(4, 'Cups', 'Flour'),
        Ingredient(2, 'Cups', 'Sugar'),
        Ingredient(0.5, 'Cups', 'Chocolate Chips'),
      ],
    ),
    Recipe(
      'Omelette',
      'assets/images/food_pics/omelette.png',
      1,
      [
        Ingredient(3, 'Full', 'Eggs'),
        Ingredient(3, 'Tea Spoons', 'Salt'),
        Ingredient(3, 'Full', 'Tomatoes'),
        Ingredient(3, 'Full', 'Onions'),
      ],
    ),
    Recipe(
      'Samosa',
      'assets/images/food_pics/samosa.png',
      9,
      [
        Ingredient(4, 'Cups', 'Flour'),
        Ingredient(3, 'Tea Spoons', 'Salt'),
        Ingredient(1, 'Kg', 'Minced Meat'),
      ],
    ),
    Recipe(
      'Pancakes',
      'assets/images/food_pics/pancakes.png',
      2,
      [
        Ingredient(4, 'Cups', 'Flour'),
        Ingredient(3, 'Tea Spoons', 'Salt'),
        Ingredient(3, 'Tea Spoons', 'Sugar'),
        Ingredient(3, 'Full', 'Eggs'),
      ],
    ),
    Recipe(
      'French Fries',
      'assets/images/food_pics/french-fries.png',
      2,
      [
        Ingredient(2, 'Jar', 'rFench Potatoes'),
        Ingredient(0.5, 'Jar', 'Sauce'),
        Ingredient(3, 'Tea Spoons', 'Salt'),
      ],
    ),
  ];
}

//todo add ingredient() here
class Ingredient {
  double ingredientQuantity;
  String ingredientMeasure;
  String ingredientName;
  Ingredient(
    this.ingredientQuantity,
    this.ingredientMeasure,
    this.ingredientName,
  );
}

class Properties {
  String propertyTitle;
  String propertyMainImageUrl;
  String propertyDescription;
  double propertyCost;
  String costInterval;
  String propertyLocation;
  Properties(
    this.propertyTitle,
    this.propertyMainImageUrl,
    this.propertyDescription,
    this.propertyCost,
    this.propertyLocation,
    this.costInterval,
  );
}
//todo add property rating
//todo add property category
//todo add property purpose
//todo add property type
