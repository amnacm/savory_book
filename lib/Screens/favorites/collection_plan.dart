import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:savory_book/Screens/items/db_food_details.dart';
import 'package:savory_book/model/food_model.dart';

class FoodItemGesture extends StatelessWidget {
  final Food foodRecipe;
  final double screenWidth;
  const FoodItemGesture({super.key, required this.foodRecipe, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => FoodDetailsDB(
                foodRecipe: foodRecipe),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(10),
              child: Opacity(
                opacity: 0.7,
                child: foodRecipe.foodImagePath !=
                        null
                    ? kIsWeb
                        ? Image.memory(
                            base64Decode(foodRecipe
                                .foodImagePath!),
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(foodRecipe
                                .foodImagePath!),
                            fit: BoxFit.cover,
                          )
                    : const Icon(
                        Linecons.food,
                        color: Color(0xFF5D5D5D),
                        size: 100,
                      ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  Text(
                    foodRecipe.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: screenWidth > 700 ? 30 : 25,
                      height: 0.8,
                    ),
                  ),
                  Text(
                    foodRecipe.category,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth > 700 ? 21 : 17,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}