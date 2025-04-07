import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextButtonUsable extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onPressed;
  final String text;
  const TextButtonUsable({super.key, required this.backgroundColor, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(text,style: const TextStyle(fontSize: 20),),
    );
  }
}