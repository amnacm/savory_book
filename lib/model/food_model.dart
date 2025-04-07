import 'package:hive_flutter/adapters.dart';
part 'food_model.g.dart';

@HiveType(typeId: 1)
class Food extends HiveObject {
  @HiveField(0)
  final String? foodImagePath;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String cookTime;

  @HiveField(3)
  final String category;

  @HiveField(4)
  final List<String> ingredients;

  @HiveField(5)
  final String preparation;

  @HiveField(6)
  final String calories;

  @HiveField(7)
  final String protein;

  @HiveField(8)
  final String carbohydrates;

  @HiveField(9)
  final String fats;

  @HiveField(10)
  int? id;

   @HiveField(11)
  bool isCollected;

   @HiveField(12)
  DateTime? addedtoList;

  Food(
      {required this.foodImagePath,
      required this.title,
      required this.cookTime,
      required this.category,
      required this.ingredients,
      required this.preparation,
      required this.calories,
      required this.protein,
      required this.carbohydrates,
      required this.fats,
      this.id,
      this.isCollected = false,});
}
