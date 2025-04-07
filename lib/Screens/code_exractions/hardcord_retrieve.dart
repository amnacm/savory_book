import 'package:flutter/material.dart';
import 'package:fluttericon/linecons_icons.dart';
import 'package:savory_book/Screens/items/coded_item_screen.dart';

class HardcodeRetreive extends StatelessWidget {
  final List<Map<String, String>> hardcodedFilteredItems;
  const HardcodeRetreive({super.key, required this.hardcodedFilteredItems});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        if (hardcodedFilteredItems.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(left: 7.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Popular Recipes',
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: hardcodedFilteredItems.length,
                itemBuilder: (context, index) {
                  final food = hardcodedFilteredItems[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CodedItemScreen(
                            food: food,
                          ),
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
                              child: food["image"] != null
                                  ? Image.asset(
                                      food["image"]!,
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
                                  food["name"] ?? "No name",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth > 700 ? 30 : 20,
                                    height: 0.8,
                                  ),
                                ),
                                Text(
                                  food["category"] ?? "No Category",
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
                itemCount: hardcodedFilteredItems.length,
                itemBuilder: (context, index) {
                  final food = hardcodedFilteredItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => CodedItemScreen(
                              food: food,
                            ),
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
                                child: food["image"] != null
                                    ? Image.asset(
                                        food["image"]!,
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
                                    food["name"] ?? "No name",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 26,
                                      height: 0.8,
                                    ),
                                  ),
                                  Text(
                                    food["category"] ?? "No Category",
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
  }
}
