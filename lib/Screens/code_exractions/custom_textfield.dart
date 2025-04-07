import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color: const Color(0xFF6E6E6E),
            // fontSize: 18,
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
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      style: const TextStyle(fontSize: 18),
      maxLines: null,
      minLines: 2,
      decoration: InputDecoration(
        fillColor: const Color(0xFFD9D9D9),
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color:const Color(0xFF6E6E6E),
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
    return TextFormField(
      controller: controller,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        fillColor: const Color(0xFFD9D9D9),
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

//----------- Orange Button for saving data
class SavingGreenOrange extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const SavingGreenOrange(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        backgroundColor:  const Color(0xFFE08C43),
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

//----------- Orange Button for cancel data
class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CancelButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        foregroundColor:  Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                color: Colors.black, width: 1.5)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
