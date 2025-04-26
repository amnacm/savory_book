import 'package:flutter/material.dart';
import 'package:savory_book/Screens/code_exractions/appbar_theme.dart';
import 'package:savory_book/screens/favorites/collection_plan.dart';
import 'package:savory_book/functions/db_function.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             OurAppBarTheme(
              title: 'Collection',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: foodListNotifier,
                builder: (context, foodList, child) {
                  final collectedFood = foodList
                      .where((food) => food.isCollected)
                      .toList()
                    ..sort((a, b) => a.addedtoList!.compareTo(b.addedtoList!));
                  if (collectedFood.isEmpty) {
                    return const Center(
                      child: Text('No collected items found.'),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: screenWidth > 500
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: collectedFood.length,
                            itemBuilder: (context, index) {
                              final foodRecipe = collectedFood[index];
                              return FoodItemGesture(
                                  foodRecipe: foodRecipe,
                                  screenWidth: screenWidth);
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: collectedFood.length,
                            itemBuilder: (context, index) {
                              final foodRecipe = collectedFood[index];
                              return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: FoodItemGesture(
                                      foodRecipe: foodRecipe,
                                      screenWidth: screenWidth));
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
