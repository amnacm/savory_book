import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/user_model.dart';

final userBox = Hive.box<User>('userBox');
final firstUser = userBox.get('userData');

final ValueNotifier<User> userNotifier = ValueNotifier<User>(firstUser!);

Future<void> resetPin(User editedUser) async {
  final userDB = await Hive.openBox<User>('userBox');

  await userDB.put('userData', editedUser);

  userNotifier.value = editedUser;

  // ignore: invalid_use_of_protected_member
  userNotifier.notifyListeners();
}

final ValueNotifier<List<Food>> foodListNotifier = ValueNotifier([]);

Future<void> addFoodRecipe(Food item) async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  int id = await foodDB.add(item);
  item.id = id;

  await foodDB.put(id, item);

  // Update the local notifier
  foodListNotifier.value.add(item);
  // ignore: invalid_use_of_protected_member
  foodListNotifier.notifyListeners();
}

//----------------getAllfoods Function-----------
Future<void> getAllFoods() async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  foodListNotifier.value.clear();

  foodListNotifier.value.addAll(foodDB.values);
  // ignore: invalid_use_of_protected_member
  foodListNotifier.notifyListeners();
}

//--------------Delete Food Recipe--------------
Future<void> deleteFoodRecipe(int index) async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  final key = foodDB.keyAt(index);

  await foodDB.delete(key);

  await getAllFoods();
}

//-------------Edit Food Recipe
Future<void> editFoodRecipe(int index, Food editedFood) async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  final key = foodDB.keyAt(index);

  editedFood.id = key;

  await foodDB.put(key, editedFood);

  await getAllFoods();
}
