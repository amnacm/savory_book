import 'dart:io';
import 'package:flutter/material.dart';
import 'package:savory_book/Screens/profile/user_edit_screen.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/user_model.dart';

class UserScreen extends StatelessWidget {
  final User user;
  const UserScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20),
              child: Text(
                'Details',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 300,
                height: 450,
                child: ValueListenableBuilder<User>(
                  valueListenable: userNotifier,
                  builder: (context, user, child) {
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
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => UserEditScreen(
                                            user: user,
                                          )));
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
                                          File(user.imagePath!),
                                        ),
                                      )
                                    : null,
                              ),
                              child: user.imagePath == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              user.password,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
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
    );
  }
}
