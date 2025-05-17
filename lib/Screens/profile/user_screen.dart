import 'dart:io';
import 'package:flutter/material.dart';
import 'package:savory_book/Screens/code_exractions/appbar_theme.dart';
import 'package:savory_book/Screens/login_page.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/screens/profile/user_edit_screen.dart';
import 'package:savory_book/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserScreen extends StatelessWidget {
  final User user;
  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            OurAppBarTheme(
              title: 'User Details',
              onTap:null,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Log Out"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                final settingsBox =
                                    await Hive.openBox('settingsBox');
                                await settingsBox.put('isLoggedIn', false);

                               Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Loginscreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                              },
                              child: const Text("Log Out"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 15, top: 20),
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        height: 450,
                        child: ValueListenableBuilder<User?>(
                          valueListenable: userNotifier,
                          builder: (context, user, child) {
                            if (user == null) {
                              return const Center(
                                child: Text("No user found",
                                    style: TextStyle(fontSize: 20)),
                              );
                            }
                            return Card(
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton.outlined(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) =>
                                                  UserEditScreen(user: user),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit_rounded),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey[300],
                                        image: user.imagePath != null
                                            ? DecorationImage(
                                                image: FileImage(
                                                    File(user.imagePath!)),
                                              )
                                            : null,
                                      ),
                                      child: user.imagePath == null
                                          ? const Icon(Icons.person,
                                              size: 80, color: Colors.grey)
                                          : null,
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      user.name,
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      user.password,
                                      style: const TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
