import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/user_model.dart';

final userBox = Hive.box<User>('userBox');
final firstUser = userBox.get('userData');
void getUser() {
  final userDB = Hive.box<User>('userBox');

  userNotifier.value = userDB.get('userData');
  // ignore: invalid_use_of_protected_member
  userNotifier.notifyListeners();
}

final ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);

// void getUser() {
//   final userDB = Hive.box<User>('userBox');
//   userNotifier.value = userDB.get('userData'); // Get user using 'userData' key
//   userNotifier.notifyListeners();
// }


// Future<void> resetPin(User editedUser) async {
//   final userDB = await Hive.openBox<User>('userBox');

//   await userDB.put('userData', editedUser);

//   userNotifier.value = editedUser;

//   // ignore: invalid_use_of_protected_member
//   userNotifier.notifyListeners();
// }

final ValueNotifier<List<Food>> foodListNotifier = ValueNotifier([]);

Future<void> addFoodRecipe(Food item) async {
  final foodDB = Hive.box<Food>('foodBox');

  await foodDB.put(item.id, item);
  getAllFoods();
}

//----------------getAllfoods Function-----------
void getAllFoods() {
  final foodDB = Hive.box<Food>('foodBox');

  foodListNotifier.value.clear();

  foodListNotifier.value.addAll(foodDB.values);

  // ignore: invalid_use_of_protected_member
  foodListNotifier.notifyListeners();
  log("get all${foodListNotifier.value.toString()}");
}

//--------------Delete Food Recipe--------------
Future<void> deleteFoodRecipe(int index) async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  final key = foodDB.keyAt(index);

  await foodDB.delete(key);

  getAllFoods();
}

//-------------Edit Food Recipe
Future<void> editFoodRecipe(int index, Food editedFood) async {
  final foodDB = await Hive.openBox<Food>('foodBox');

  await foodDB.put(index, editedFood);

  getAllFoods();
}

String generataId() {
  return DateTime.now().microsecondsSinceEpoch.remainder(4294967295).toString();
}
