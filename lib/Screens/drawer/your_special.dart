import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/Screens/code_exractions/appbar_theme.dart';
import 'package:savory_book/Screens/drawer/food_edit.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/food_model.dart';

class YourSpecial extends StatefulWidget {
  const YourSpecial({super.key});

  @override
  State<YourSpecial> createState() => _YourSpecialState();
}

bool isCollected = false;

class _YourSpecialState extends State<YourSpecial> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //------Appbar
            OurAppBarTheme(
              title: 'Your Specials',
              onTap: (){
                Navigator.pop(context);
              }
            ),
            
            //----------Responsive List/Grid
            ValueListenableBuilder(
              valueListenable: foodListNotifier,
              builder: (BuildContext context, List<Food> food, Widget? child) {
                if (food.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(child: Text('No items added'),),
                  );
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Check the width of the screen and decide whether to use ListView or GridView
                          if (constraints.maxWidth < 500) {
                            // For smaller screens, use ListView
                            return ListView.builder(
                              itemCount: food.length,
                              itemBuilder: (context, index) {
                                final foodRecipe = food[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
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
                                                        base64Decode(foodRecipe.foodImagePath!),
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
                                          padding: const EdgeInsets.only(left: 10,bottom: 10, right: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                ],
                                              ),
                                  
                                              // Action buttons
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      final settingsBox = Hive.box('settingsBox');
                                                      final userEmail = settingsBox.get('userEmail');
                                          
                                                      final updatedFood = await Navigator.of(context).push<Food>(
                                                        MaterialPageRoute(
                                                          builder: (ctx) => EditFoodScreen(foodRecipe: foodRecipe, index: index),
                                                        ),
                                                      );
                                          
                                                      if (updatedFood != null) {
                                                        editFoodRecipe(userEmail, updatedFood);
                                                      }
                                                    },
                                                    icon: const Icon(Icons.mode_edit_outline_outlined, size: 24, color: Colors.white,),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await deleteConfirmation(context, index);
                                                    },
                                                    icon: const Icon(Icons.delete_outline_rounded, size: 24, color: Colors.white,),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            // For larger screens, use GridView
                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 3/2
                              ),
                              itemCount: food.length,
                              itemBuilder: (context, index) {
                                final foodRecipe = food[index];
                                return Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: foodRecipe.foodImagePath == null
                                            ? const Icon(Linecons.food, size: 80, color: Colors.grey)
                                            : Opacity(
                                              opacity: 0.6,
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: foodRecipe.foodImagePath != null
                                                      ? kIsWeb
                                                          ? Image.memory(
                                                              base64Decode(foodRecipe.foodImagePath!),
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
                                      ),
                                      const SizedBox(height: 8),
                                      // Title and Category
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              foodRecipe.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:20,
                                                height: 0.8,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        
                                            const SizedBox(height: 4),
                                            Text(
                                              foodRecipe.category,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17,
                                                height: 0.8,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // Action buttons
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    final settingsBox = Hive.box('settingsBox');
                                                    final userEmail = settingsBox.get('userEmail');
                                        
                                                    final updatedFood = await Navigator.of(context).push<Food>(
                                                      MaterialPageRoute(
                                                        builder: (ctx) => EditFoodScreen(foodRecipe: foodRecipe, index: index),
                                                      ),
                                                    );
                                        
                                                    if (updatedFood != null) {
                                                      editFoodRecipe(userEmail, updatedFood);
                                                    }
                                                  },
                                                  icon: const Icon(Icons.mode_edit_outline_outlined, size: 24, color: Colors.white,),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    await deleteConfirmation(context, index);
                                                  },
                                                  icon: const Icon(Icons.delete_outline_rounded, size: 24, color: Colors.white,),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                );
                              
                              },
                            );


                          }
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteConfirmation(BuildContext context, int index) async{
    final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete this recipe?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    deleteFoodRecipe(index);
  }
  }
}