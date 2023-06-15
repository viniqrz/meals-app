import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  final Function(Meal meal) onToggleFavorite;
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(meal);
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    meal.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                  const SizedBox(height: 32),
                  Column(
                    children: [
                      for (final ingredient in meal.ingredients)
                        Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        )
                    ],
                  ),
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final step in meal.steps)
                        Column(
                          children: [
                            Text(
                              '✅ $step',
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}