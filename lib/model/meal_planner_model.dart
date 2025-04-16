import 'package:hive_flutter/adapters.dart';
part 'meal_planner_model.g.dart';

@HiveType(typeId: 2)
class MealPlannerModel {
  @HiveField(0)
  final String day;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  MealPlannerModel(
      {required this.day, required this.name, required this.category});
}
