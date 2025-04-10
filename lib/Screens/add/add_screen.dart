import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savory_book/screens/code_exractions/custom_textfield.dart';
import 'package:savory_book/screens/code_exractions/whole_custom_textfield.dart';
import 'package:savory_book/functions/nr_function.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();

  String? addFoodImagePath;

  final _nameController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();
  final _preparationController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbohydratesController = TextEditingController();
  final _fatsController = TextEditingController();
  final List<TextEditingController> _ingredientsControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  Future<void> _pickImage() async {
    // Mobile: Use file path
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        addFoodImagePath = pickedImage.path; // Store file path
      });
    }
  }

  void callingTheAddingFunc() {
    final name = _nameController.text;
    final cookTime = _cookTimeController.text;
    final category = _categoryController.text.trim();
    final type = _typeController.text.trim();
    final preperation = _preparationController.text;
    final calories = _caloriesController.text;
    final carbohydrates = _carbohydratesController.text;
    final protein = _proteinController.text;
    final fats = _fatsController.text;
    final ingredients = _ingredientsControllers
        .map((controller) => controller.text.trim())
        .where((ingredient) => ingredient.isNotEmpty)
        .toList();

    publishingFood(name, cookTime, category, type, preperation, calories,
        carbohydrates, protein, fats, ingredients, context, addFoodImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
            children: [
              const Text(
                "Recipe Image:",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(12),
                    image: addFoodImagePath != null
                        ? DecorationImage(
                            image: FileImage(File(addFoodImagePath!)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: addFoodImagePath == null
                      ? const Icon(
                          Icons.image_outlined,
                          color: Colors.grey,
                          size: 60,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      WholeCustomTextField(
                          name: _nameController,
                          cookTime: _cookTimeController,
                          category: _categoryController,
                          type: _typeController),

                      //Ingredients
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Ingredients",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          )),

                      Column(
                        children: List.generate(_ingredientsControllers.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextfield(
                                    controller: _ingredientsControllers[index],
                                    hintText: 'Ingredient ${index + 1}',
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Provide ingredient';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_rounded),
                                  onPressed: () {
                                    setState(() {
                                      _ingredientsControllers.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      ),

                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            _ingredientsControllers
                                .add(TextEditingController());
                          });
                        },
                        label: const Text(
                          'Ingredient',
                          style: TextStyle(fontSize: 18),
                        ),
                        icon: Icon(
                          Icons.add_rounded,
                          color: Colors.black,
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xEBEAEAEA),
                            foregroundColor: Colors.black),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Cooking Process
                      MultilineTextfield(
                          controller: _preparationController,
                          hintText: 'Describe your cooking process here...',
                          errorText: 'Explain your your cooking process'),
                      const SizedBox(
                        height: 15,
                      ),

                      //Nutritional Information
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nutritional Information",
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.w500),
                          )),

                      //Calories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              width: 150,
                              child: Text(
                                'Calories',
                                style: TextStyle(fontSize: 20),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: NutritionalTextField(
                                  controller: _caloriesController,
                                  suffixText: 'kcal',
                                  errorText: 'Give the Calories of your food')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Protien
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              width: 150,
                              child: Text(
                                'Protien',
                                style: TextStyle(fontSize: 20),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: NutritionalTextField(
                                  controller: _proteinController,
                                  suffixText: 'g.',
                                  errorText: 'Give the Protien of your food')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Carbohydrates
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              width: 150,
                              child: Text(
                                'Carbohydrates',
                                style: TextStyle(fontSize: 20),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: NutritionalTextField(
                                  controller: _carbohydratesController,
                                  suffixText: 'g.',
                                  errorText:
                                      'Give the Carbohydrates of your food')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Fats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              width: 150,
                              child: Text(
                                'Fats',
                                style: TextStyle(fontSize: 20),
                              )),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(
                              child: NutritionalTextField(
                                  controller: _fatsController,
                                  suffixText: 'g.',
                                  errorText: 'Give the Fats of your food')),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Publish Button--------
                      SavingGreenOrange(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              callingTheAddingFunc();
                              _nameController.clear();
                              _cookTimeController.clear();
                              _categoryController.clear();
                              for (var controller in _ingredientsControllers) {
                                controller.clear();
                              }
                              _ingredientsControllers.removeRange(
                                  2, _ingredientsControllers.length);
                              _typeController.clear();
                              _preparationController.clear();
                              _caloriesController.clear();
                              _proteinController.clear();
                              _carbohydratesController.clear();
                              _fatsController.clear();
                              setState(() {
                                addFoodImagePath = null;
                              });
                            }
                          },
                          text: "Publish"),

                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _cookTimeController.dispose();
    _categoryController.dispose();
    _typeController.dispose();
    _preparationController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbohydratesController.dispose();
    _fatsController.dispose();
    for (final controller in _ingredientsControllers) {
      controller.dispose();
    }
  }
}
