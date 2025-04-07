import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:savory_book/Screens/items/db_food_details.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/food_model.dart';

class HomeDbRetrieve extends StatelessWidget {
  final String selectedItem;
  final TextEditingController searchController;
  const HomeDbRetrieve(
      {super.key, required this.selectedItem, required this.searchController});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ValueListenableBuilder<List<Food>>(
      valueListenable: foodListNotifier,
      builder: (context, foodList, child) {
        final filteredList = foodList
            .where((food) =>
                (selectedItem == "All" || food.category == selectedItem) &&
                food.title
                    .toLowerCase()
                    .contains(searchController.text.toLowerCase()))
            .toList();

        return Column(
          children: [
            if (filteredList.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(left: 7.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'My Recipe',
                    style: TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600, height: 1),
                  ),
                ),
              ),
            const SizedBox(height: 7),
            screenWidth > 500
                ? GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 3 / 2,
                    ),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final foodRecipe = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  FoodDetailsDB(foodRecipe: foodRecipe),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Opacity(
                                  opacity: 0.6,
                                  child: foodRecipe.foodImagePath != null
                                      ? kIsWeb
                                          ? Image.memory(
                                              base64Decode(
                                                  foodRecipe.foodImagePath!),
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(foodRecipe.foodImagePath!),
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      foodRecipe.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: screenWidth > 700 ? 30 : 20,
                                        height: 0.8,
                                      ),
                                    ),
                                    Text(
                                      foodRecipe.category,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: screenWidth > 700 ? 21 : 15,
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
                    },
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final foodRecipe = filteredList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) =>
                                    FoodDetailsDB(foodRecipe: foodRecipe),
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
                                  borderRadius: BorderRadius.circular(10),
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: foodRecipe.foodImagePath != null
                                        ? kIsWeb
                                            ? Image.memory(
                                                base64Decode(
                                                    foodRecipe.foodImagePath!),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(foodRecipe.foodImagePath!),
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
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        foodRecipe.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 26,
                                          height: 0.8,
                                        ),
                                      ),
                                      Text(
                                        foodRecipe.category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
