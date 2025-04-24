import 'package:flutter/material.dart';
import 'package:savory_book/Screens/code_exractions/color.dart';
import 'package:savory_book/main.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        fillColor:
            isDarkMode ? const Color(0xFF545454) : const Color(0xFFD9D9D9),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color:
                isDarkMode ? const Color(0xFFD9D9D9) : const Color(0xFF6E6E6E),
            fontWeight: FontWeight.w400),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
      ),
      validator: validator,
    );
  }
}

class MultilineTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  const MultilineTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 18),
      maxLines: null,
      minLines: 2,
      decoration: InputDecoration(
        fillColor:
            isDarkMode ? const Color(0xFF545454) : const Color(0xFFD9D9D9),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color:
                isDarkMode ? const Color(0xFFD9D9D9) : const Color(0xFF6E6E6E),
            fontSize: 18,
            fontWeight: FontWeight.w400),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}

class NutritionalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String suffixText;
  final String errorText;
  const NutritionalTextField(
      {super.key,
      required this.controller,
      required this.suffixText,
      required this.errorText});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor:
            isDarkMode ? const Color(0xFF545454) : const Color(0xFFD9D9D9),
        filled: true,
        suffix: Text(
          suffixText,
          style: const TextStyle(color: Colors.black),
        ),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(9)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}

//----------- grey Button for saving data
class SavingGreenOrange extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const SavingGreenOrange(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        backgroundColor: isDarkMode ? darkModeColor : const Color(0xFF50606F),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

//----------- grey Button for cancel data
class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CancelButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = themeNotifier.value;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: isDarkMode ? Colors.white : Colors.black, width: 1.5)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
