import 'package:flutter/material.dart';
import 'package:savory_book/Functions/db_function.dart';
import 'package:savory_book/functions/snackbar.dart';
import 'package:savory_book/model/food_model.dart';

Future<void> publishingFood(
  String name,
  String cookTime,
  String category,
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
    category: category,
    ingredients: ingredients,
    preparation: preperation,
    calories: calories,
    protein: protein,
    carbohydrates: carbohydrates,
    fats: fats,
  );

  addFoodRecipe(foodRecipeItem);

  showSnackBar(context, 'Your Food Recipe added succefully');
}

// function for validators
String? validateField({
  required String? value,
  required String fieldName,
  String? allowedValues,
  String? email,
  bool isNumeric = false,
  bool isRequired = true,
}) {
  if (isRequired && (value == null || value.trim().isEmpty)) {
    return '$fieldName is required';
  }

  if (isRequired && (value == null || value.trim().isEmpty)) {
    return '$fieldName is required';
  }

  if (email != null &&
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email)) {
    return 'Enter a valid Email';
  }

  return null;
}
