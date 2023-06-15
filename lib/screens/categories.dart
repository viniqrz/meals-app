import 'package:flutter/material.dart';
import 'package:meals/data/dummy.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) async {
    List<Meal> meals = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          meals: meals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
