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

  void signOutUser() async {
    final userBox = Hive.box('userBox');
    await userBox.clear(); 
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  void deleteAccount() async {
    final userBox = Hive.box('userBox');
    await userBox.deleteFromDisk();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
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
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text("Sign Out", style: TextStyle(fontSize: 18)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Sign Out"),
                          content: Text("Are you sure you want to sign out?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                signOutUser();
                              },
                              child: Text("Sign Out"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text("Delete Account", style: TextStyle(fontSize: 18)),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Delete Account"),
                          content: Text("Are you sure you want to delete your account permanently?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                deleteAccount();
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
