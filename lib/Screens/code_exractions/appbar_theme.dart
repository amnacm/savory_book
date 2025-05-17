import 'package:flutter/material.dart';
import 'package:savory_book/main.dart';
import 'package:savory_book/screens/code_exractions/color.dart';

class OurAppBarTheme extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final List<Widget>? actions;

  const OurAppBarTheme({
    super.key,
    required this.title,
    this.onTap, 
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return Container(
      width: double.infinity,
      color: isDarkMode ? darkModeColor : const Color(0xFFD2AB94),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              if (onTap != null)
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
          if (actions != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions!,
            ),
        ],
      ),
    );
  }
}


