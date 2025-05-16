import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/user_model.dart';

final userBox = Hive.box<User>('userBox');
final ValueNotifier<User?> userNotifier = ValueNotifier<User?>(null);
final ValueNotifier<List<Food>> foodListNotifier = ValueNotifier([]);

//------------------ GET USER ------------------
void getUser() {
  final userDB = Hive.box<User>('userBox');
  if (userDB.isNotEmpty) {
    final firstKey = userDB.keys.first;
    final user = userDB.get(firstKey);
    userNotifier.value = user;
  } else {
    userNotifier.value = null;
  }
  userNotifier.notifyListeners();
}

//------------------ UPDATE USER ------------------
Future<void> updateUser(User updatedUser) async {
  final userDB = Hive.box<User>('userBox');
  if (userDB.isNotEmpty) {
    final oldUserKey = userDB.keys.first;
    final oldUser = userDB.get(oldUserKey);

    if (oldUser != null && oldUser.email != updatedUser.email) {
      await userDB.delete(oldUserKey);
      await userDB.put(updatedUser.email, updatedUser);
    } else {
      await userDB.put(oldUserKey, updatedUser);
    }

    userNotifier.value = updatedUser;
    userNotifier.notifyListeners();
  }
}



//------------------ ADD FOOD ------------------
Future<void> addFoodRecipe(Food item) async {
  final foodDB = Hive.box<Food>('foodBox');
  await foodDB.put(item.id, item);
  getAllFoods();
}

//------------------ GET ALL FOODS ------------------
void getAllFoods() {
  final foodDB = Hive.box<Food>('foodBox');
  foodListNotifier.value = foodDB.values.toList();
  foodListNotifier.notifyListeners();
  log("get all: ${foodListNotifier.value}");
}

//------------------ DELETE FOOD ------------------
Future<void> deleteFoodRecipe(int index) async {
  final foodDB = await Hive.openBox<Food>('foodBox');
  final key = foodDB.keyAt(index);
  await foodDB.delete(key);
  getAllFoods();
}

//------------------ EDIT FOOD ------------------
Future<void> editFoodRecipe(int index, Food editedFood) async {
  final foodDB = await Hive.openBox<Food>('foodBox');
  await foodDB.put(index, editedFood);
  getAllFoods();
}

//------------------ ID GENERATOR ------------------
String generataId() {
  return DateTime.now().microsecondsSinceEpoch.remainder(4294967295).toString();
}
