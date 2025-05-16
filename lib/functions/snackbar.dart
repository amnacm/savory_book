import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/model/meal_planner_model.dart';

void showSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.red}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 2),
    ),
  );
}

Future<void> openAlert(BuildContext context, Map<String, String> food) async {
  String? selectedDay;
  String? selectedCategory;
  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];
  final List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add to Meal Planner'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select day'),
                  value: selectedDay,
                  items: days.map((String day) {
                    return DropdownMenuItem<String>(
                      value: day,
                      child: Text(day),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedDay = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select a category'),
                  value: selectedCategory,
                  items: categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (selectedDay != null && selectedCategory != null) {
                    final mealBox = Hive.box<MealPlannerModel>('mealBox');
                    final existingMeal = mealBox.values.any(
                      (meal) =>
                          meal.day == selectedDay &&
                          meal.category == selectedCategory,
                    );

                    if (existingMeal) {
                      showSnackBar(context,
                          '$selectedCategory is already filled for $selectedDay.',
                          backgroundColor: Colors.redAccent);
                      return;
                    }

                    //----- Add the new meal-----
                    mealBox.add(MealPlannerModel(
                      day: selectedDay!,
                      name: food["name"] ?? 'Unnamed Food',
                      category: selectedCategory!,
                    ));
                    Navigator.of(context).pop();
                    showSnackBar(context, 'Meal added successfully',
                        backgroundColor: Colors.green);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
