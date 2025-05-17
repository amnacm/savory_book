import 'package:flutter/material.dart';
import 'package:savory_book/screens/login_page.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:savory_book/screens/register_page.dart';

class Startingscreen extends StatelessWidget {
  const Startingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Image.asset(
              'assets/images/starting.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Color(0xFFD2AE95),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ready to start\n your cooking \njourney?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17,
                        color: Color(0xFF2C3E50),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DotsIndicator(
                    dotsCount: 3,
                    position: 2,
                    decorator: const DotsDecorator(
                      activeColor: Color(0xFF2C3E50),
                      color: Colors.white,
                      size: Size.square(9.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registerscreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2C3E50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Get start",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF2C3E50)),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Loginscreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2C3E50),
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Color(0xFF2C3E50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
