import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:savory_book/screens/drawer/privacy_policy.dart';
import 'package:savory_book/screens/drawer/settings.dart';
import 'package:savory_book/screens/drawer/your_special.dart';
import 'package:savory_book/screens/profile/user_screen.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/user_model.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    log(userNotifier.value.toString());
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 20),
          child: Column(
            children: [
              ValueListenableBuilder<User?>(
                valueListenable: userNotifier,
                builder: (BuildContext context, User? user, Widget? child) {
                  if (user == null) {
                    return const Center(
                      child: Text(
                        "No user found",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  log(userNotifier.value.toString());
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => UserScreen(user: user)));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                            image: user.imagePath != null
                                ? DecorationImage(
                                    image: FileImage(File(user.imagePath!)))
                                : null,
                          ),
                          child: user.imagePath == null
                              ? const Icon(
                                  Icons.person,
                                  size: 70,
                                  color: Colors.grey,
                                )
                              : null,
                        ),
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    //----------Privacy & Policy
                    _buildDrawerItem(
                        icon: Icons.privacy_tip_outlined,
                        text: 'Privacy & Policy',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PrivacyPolicy()));
                        }),

                    //----------Your specials
                    _buildDrawerItem(
                        icon: Icons.archive_outlined,
                        text: 'Your Specials',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const YourSpecial()));
                        }),

                    //----------Settings
                    _buildDrawerItem(
                        icon: Icons.settings_outlined,
                        text: 'Settings',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const SettingsScreen()));
                        }),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Version 1.1.0",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
