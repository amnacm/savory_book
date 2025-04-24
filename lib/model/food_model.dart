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
  final String type;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final String difficulty;

  @HiveField(6)
  final List<String> ingredients;

  @HiveField(7)
  final String preparation;

  @HiveField(8)
  final String calories;

  @HiveField(9)
  final String protein;

  @HiveField(10)
  final String carbohydrates;

  @HiveField(11)
  final String fats;

  @HiveField(12)
  int? id;

  @HiveField(13)
  bool isCollected;

  @HiveField(14)
  bool isAddedtoPlan;

  @HiveField(15)
  DateTime? addedtoList;

  Food({
    required this.foodImagePath,
    required this.title,
    required this.cookTime,
    required this.type,
    required this.category,
    required this.difficulty,
    required this.ingredients,
    required this.preparation,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    this.isCollected = false,
    this.isAddedtoPlan = false,
    this.id,
  });
}
