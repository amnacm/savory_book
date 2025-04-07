import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:savory_book/screens/instruction_three.dart';

class Secondpage extends StatelessWidget {
  const Secondpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Image.asset(
              'assets/images/girlchef.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFD2AE95),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "With SavoryBook, you can save, organize, and access your favorite recipes anytime—even offline. Explore new flavors, cook with confidence, and keep your personal cookbook always at your fingertips. From quick snacks to gourmet meals, everything you need is just a tap away. Start cooking and create delicious memories today!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Color(0xFF2C3E50)),
                  ),
                  SizedBox(height: 10),
                  DotsIndicator(
                    dotsCount: 3,
                    position: 1,
                    decorator: const DotsDecorator(
                      activeColor: Color(0xFF2C3E50),
                      color: Colors.white,
                      size: Size.square(9.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Startingpage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2C3E50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Back",
                            style: TextStyle(color: Color(0xFF2C3E50)),
                          )),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Startingpage()),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Color(0xFF2C3E50)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
