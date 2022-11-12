import 'package:flutter/material.dart';

import '../../../widgets/custom_bottom_navigation.dart';
import 'recipes_body.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({Key? key}) : super(key: key);
  static String routeName = '/recipes_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recipes',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune_outlined,
            ),
          ),
        ],
      ),
      body: const RecipesBody(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
