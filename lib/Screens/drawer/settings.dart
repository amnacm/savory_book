import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/Screens/code_exractions/appbar_theme.dart';
import 'package:savory_book/functions/snackbar.dart';
import 'package:savory_book/main.dart';
import 'package:savory_book/model/user_model.dart';
import 'package:savory_book/screens/register_page.dart';

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
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title:
                        Text("Delete Account", style: TextStyle(fontSize: 18)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Delete Account"),
                          content: Text(
                              "Are you sure you want to delete your account permanently?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async {
                                final userBox =
                                    await Hive.openBox<User>('userBox');
                                await userBox.clear();
                                showSnackBar(context, "Account Deleted",backgroundColor: Colors.green);
                                await Future.delayed(Duration(seconds: 2));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Registerscreen()),
                                );
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
