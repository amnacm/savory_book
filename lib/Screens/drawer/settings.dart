import 'package:flutter/material.dart';
import 'package:savory_book/screens/code_exractions/appbar_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
 
@override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          OurAppBarTheme (
            title: 'Settings',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    "Dark Theme",style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
