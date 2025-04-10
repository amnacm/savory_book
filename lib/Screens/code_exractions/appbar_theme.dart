import 'package:flutter/material.dart';

class OurAppBarTheme extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const OurAppBarTheme({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFD2AB94),
      height: 70,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
          )
        ],
      ),
    );
  }
}
