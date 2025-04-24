import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/main.dart';
import 'package:savory_book/screens/code_exractions/appbar_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    final settingsBox = Hive.box('settingsBox');
    isDarkMode = settingsBox.get('isDarkMode', defaultValue: false);
  }

  void toggleDarkMode(bool value) async {

    setState(() {
      isDarkMode = value;
      themeNotifier.value = value;
    });

    final settingsBox = Hive.box('settingsBox');
    await settingsBox.put('isDarkMode', isDarkMode);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          OurAppBarTheme(
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
                    "Dark Theme",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: toggleDarkMode,
                    activeColor: Colors.grey[300],
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
