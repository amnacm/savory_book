import 'package:flutter/material.dart';
import 'package:savory_book/functions/nr_function.dart';
import 'package:savory_book/screens/code_exractions/custom_textfield.dart';

class WholeCustomTextField extends StatefulWidget {
  final TextEditingController name;
  final TextEditingController cookTime;
  final TextEditingController category;
  final TextEditingController type;
  final TextEditingController difficulty;

  const WholeCustomTextField(
      {super.key,
      required this.name,
      required this.cookTime,
      required this.category,
      required this.type,
      required this.difficulty});

  @override
  State<WholeCustomTextField> createState() => _WholeCustomTextFieldState();
}

class _WholeCustomTextFieldState extends State<WholeCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextfield(
          controller: widget.name,
          hintText: 'Recipe Title',
          validator: (value) => validateField(
            value: value,
            fieldName: 'Recipe Title',
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //----------CookTime
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Cook time(average time)',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: CustomTextfield(
                controller: widget.cookTime,
                hintText: '2hr 30min',
                validator: (value) => validateField(
                  value: value,
                  fieldName: 'Cook Time',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),

        //-------Category
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  hintText: 'choose a category',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                value:
                    widget.category.text.isEmpty ? null : widget.category.text,
                items: ['Breakfast', 'Lunch', 'Snacks', 'Dinner']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    widget.category.text = value!;
                  });
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a category'
                    : null,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        //-------Type
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Type',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
                child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  hintText: 'choose a type',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              value: widget.type.text.isEmpty ? null : widget.type.text,
              items: ['Veg', 'Non-Veg']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  widget.type.text = value!;
                });
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select a type'
                  : null,
            ))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        //-------Difficulty
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Type',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 40,
            ),
            Expanded(
                child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  hintText: 'choose a level',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              value: widget.type.text.isEmpty ? null : widget.type.text,
              items: ['easy', 'medium', 'hard']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  widget.type.text = value!;
                });
              },
              validator: (value) => value == null || value.isEmpty
                  ? 'Please select a level'
                  : null,
            ))
          ],
        ),
      ],
    );
  }
}
