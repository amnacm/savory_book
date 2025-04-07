import 'package:flutter/material.dart';
import 'package:savory_book/model/food_model.dart';

class NutritionalDB extends StatelessWidget {
  final Food foodRecipe;
  const NutritionalDB({super.key, required this.foodRecipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 10)
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Image.asset(
                      'assets/images/nutritoins.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                      top: 40,
                      left: 5,
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.black,
                            size: 30,
                          )))
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Show Nutritional Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                '(per serving, 2 slices)',
                style: TextStyle(fontSize: 18),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            //--------calories
            _buildNutritionalInformation(
                itemText: "Calories :", valueText: foodRecipe.calories),

            //--------protien
            _buildNutritionalInformation(
                itemText: "Protein :", valueText: foodRecipe.protein),
            //--------carbhohydrates
            _buildNutritionalInformation(
                itemText: "Carbohydrates :",
                valueText: foodRecipe.carbohydrates),
            //--------calories
            _buildNutritionalInformation(
                itemText: "Fats :", valueText: foodRecipe.fats),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionalInformation({
    required String itemText,
    required String valueText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, bottom: 20, right: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemText,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              Text(
                valueText,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
