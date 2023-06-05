import 'package:flutter/material.dart';
import 'package:meals/components/meal_item.dart';
import 'package:meals/models/meal.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen(this.favoriteMeals, {super.key});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
        child: Text('Not exist favorites foods!'),
      );
    }

    return ListView.builder(
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        return MealItem(favoriteMeals[index]);
      },
    );
  }
}
