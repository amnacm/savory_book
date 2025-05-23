import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:savory_book/screens/instruction_three.dart';
import 'package:savory_book/screens/instruction_two.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Image.asset(
              'assets/images/chef.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(25),
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
                    "Cooking is more than just making food—it's about passion, creativity, and sharing flavors. With SavoryBook, your favorite recipes are always at your fingertips, anytime, anywhere. No internet? No problem! Save, search, and cook with ease. Your personal cookbook is now just a tap away. Let’s get cooking!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, color: Color(0xFF2C3E50)),
                  ),
                  SizedBox(height: 10),
                  DotsIndicator(
                    dotsCount: 3,
                    position: 0,
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
                        MaterialPageRoute(builder: (context) => Secondscreen()),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Startingscreen()),
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
