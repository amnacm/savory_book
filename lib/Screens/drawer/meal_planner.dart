import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/model/meal_planner_model.dart';
import 'package:savory_book/screens/code_exractions/appbar_theme.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealBox = Hive.box<MealPlannerModel>('mealBox');

    // Predefined categories
    const List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            OurAppBarTheme(
              title: 'Meal Planner',
              onTap: () => Navigator.pop(context),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: mealBox.listenable(),
                builder: (context, Box<MealPlannerModel> box, _) {
                  if (box.isEmpty) {
                    return const Center(
                      child: Text('No meals planned yet!'),
                    );
                  }

                  // Group meals by day and ensure each category exists
                  final Map<String, Map<String, MealPlannerModel?>>
                      groupedMeals = {};

                  // Initialize with empty values
                  for (var day in [
                    'Sunday',
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday'
                  ]) {
                    groupedMeals[day] = {
                      for (var category in categories) category: null,
                    };
                  }

                  // Fill with existing meals
                  for (var meal in box.values) {
                    groupedMeals[meal.day]?[meal.category] = meal;
                  }

                  return ListView(
                    children: groupedMeals.entries.map((entry) {
                      final day = entry.key;
                      final meals = entry.value;

                      return ExpansionTile(
                        title: Text(day),
                        children: meals.entries.map((mealEntry) {
                          final category = mealEntry.key;
                          final meal = mealEntry.value;

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  '$category :',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                subtitle: meal != null
                                    ? Text(
                                        meal.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      )
                                    : const Text(
                                        'No element added',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                leading: const Icon(Icons.fastfood_rounded),
                                trailing: meal != null
                                    ? IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline_rounded),
                                        onPressed: () =>
                                            deleteMeal(context, mealBox, meal),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteMeal(BuildContext context, Box<MealPlannerModel> mealBox,
      MealPlannerModel meal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Meal'),
          content: const Text('Are you sure you want to delete this meal?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final mealKey = mealBox
                    .toMap()
                    .entries
                    .firstWhere(
                      (entry) =>
                          entry.value.day == meal.day &&
                          entry.value.category == meal.category,
                    )
                    .key;

                mealBox.delete(mealKey);

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meal deleted successfully!')),
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
