import 'package:flutter/material.dart';
import 'package:savory_book/Functions/db_function.dart';
import 'package:savory_book/functions/snackbar.dart';
import 'package:savory_book/model/food_model.dart';

Future<void> publishingFood(
  String name,
  String cookTime,
  String type,
  String category,
  String difficulty,
  String preperation,
  String calories,
  String protein,
  String carbohydrates,
  String fats,
  List<String> ingredients,
  BuildContext context, [
  String? addFoodImagePath,
]) async {
  if (name.isEmpty ||
      cookTime.isEmpty ||
      category.isEmpty ||
      type.isEmpty ||
      difficulty.isEmpty ||
      ingredients.isEmpty ||
      preperation.isEmpty ||
      calories.isEmpty ||
      protein.isEmpty ||
      carbohydrates.isEmpty ||
      fats.isEmpty) {
    return showSnackBar(context, 'You missed fill out any item');
  }

  final foodRecipeItem = Food(
    foodImagePath: addFoodImagePath,
    title: name,
    cookTime: cookTime,
    type: type,
    difficulty: difficulty,
    category: category,
    ingredients: ingredients,
    preparation: preperation,
    calories: calories,
    protein: protein,
    carbohydrates: carbohydrates,
    fats: fats,
  );

  addFoodRecipe(foodRecipeItem);

  showSnackBar(context, 'Your Food Recipe added succefully',
      backgroundColor: Colors.green);
}

// function for validators
String? validateField({
  required String? value,
  required String fieldName,
  String? allowedValues,
  String? email,
  String? password,
  String? confirmPassword,
  bool isRequired = true,
}) {
  if (isRequired && (value == null || value.trim().isEmpty)) {
    return '$fieldName is required';
  }

  if (isRequired && (value == null || value.trim().isEmpty)) {
    return '$fieldName is required';
  }

  if (email != null &&
      !RegExp(r'^[a-zA-Z0-9]+@gmail\.com$').hasMatch(email.trim())) {
    return 'Enter a valid Email';
  }

  return null;
}
