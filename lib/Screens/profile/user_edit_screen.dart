import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savory_book/Screens/code_exractions/custom_textfield.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/functions/snackbar.dart';
import 'package:savory_book/main.dart';
import 'package:savory_book/model/user_model.dart';

class UserEditScreen extends StatefulWidget {
  final User user;
  const UserEditScreen({super.key, required this.user});

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.user.email);
    _nameController = TextEditingController(text: widget.user.name);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = themeNotifier.value;
    bool screenWidth = MediaQuery.of(context).size.width > 450;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    height: screenWidth ? 500 : 640,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black : Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            radius: 45,
                            backgroundImage: _selectedImagePath != null
                                ? FileImage(File(_selectedImagePath!))
                                : widget.user.imagePath != null
                                    ? FileImage(File(widget.user.imagePath!))
                                    : null,
                            child: _selectedImagePath == null &&
                                    widget.user.imagePath == null
                                ? const Icon(
                                    Icons.camera_alt_outlined,
                                    size: 35,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          onTap: () async {
                            final XFile? pickedFile =
                                await _picker.pickImage(source: ImageSource.gallery);
                            if (pickedFile != null) {
                              setState(() {
                                _selectedImagePath = pickedFile.path;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: screenWidth ? 400 : double.infinity,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 27),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(hintText: 'Email'),
                                      validator: (value) => validateField(
                                        value: value,
                                        fieldName: 'Email',
                                        email: value,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      textCapitalization: TextCapitalization.words,
                                      decoration: const InputDecoration(hintText: 'User Name'),
                                      validator: (value) =>
                                          validateField(value: value, fieldName: 'User Name'),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: _passwordController,
                                      decoration: const InputDecoration(hintText: 'Password'),
                                      validator: (value) =>
                                          validateField(value: value, fieldName: 'Password'),
                                    ),
                                    const SizedBox(height: 60),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CancelButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          text: "Cancel",
                                        ),
                                        const SizedBox(width: 10),
                                        SavingGreenOrange(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              editingUser(context);
                                            }
                                          },
                                          text: "Change",
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 Future<void> editingUser(BuildContext context) async {
  if (_formKey.currentState!.validate()) {
    final oldUser = widget.user;
    final editedUser = User(
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      imagePath: _selectedImagePath ?? oldUser.imagePath,
    );

    await saveEditedUser(oldUser, editedUser);

    showSnackBar(
      context,
      "User details updated successfully",
      backgroundColor: Colors.green,
    );
    Navigator.pop(context);
  }
}

  String? validateField({String? value, required String fieldName, String? email}) {
    if (value == null || value.isEmpty) {
      return "$fieldName cannot be empty";
    } else if (fieldName == "Email" && (email == null || !email.contains('@'))) {
      return "Enter a valid email";
    }
    return null;
  }
}
