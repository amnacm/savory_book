import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:savory_book/Screens/add/add_screen.dart';
import 'package:savory_book/Screens/favorites/collections.dart';
import 'package:savory_book/Screens/home/home_screen.dart';
import 'package:savory_book/Screens/profile/user_screen.dart';
import 'package:savory_book/model/user_model.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late final User user;
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    final userBox = Hive.box<User>('userBox');
    user = userBox.get('userData')!;

    _screens = [
      HomeScreen(user: user),
      const CollectionsScreen(),
      const AddScreen(),
      UserScreen(user: user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    {
      return Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color(0xFF8B5E3C),
          unselectedItemColor: Colors.grey,
          iconSize: 27,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'My Collections',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_rounded),
              activeIcon: Icon(Icons.add_circle),
              label: 'Add',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      );
    }
  }
}
