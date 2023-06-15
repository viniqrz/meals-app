import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/empty_meal_list_message.dart';
import 'package:meals/widgets/meal_list_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.meals,
    required this.onToggleFavorite,
    this.title,
  });

  final String? title;
  final List<Meal> meals;
  final Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (meals.isEmpty) {
      body = const EmptyMealListMessage();
    } else {
      body = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealListItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => MealDetailsScreen(
                  meal: meal,
                  onToggleFavorite: onToggleFavorite,
                ),
              ),
            );
          },
        ),
        prototypeItem: MealListItem(
          meal: meals.first,
          onSelectMeal: (Meal meal) {},
        ),
      );
    }

    if (title == null) {
      return body;
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: body,
      );
    }
  }
}
