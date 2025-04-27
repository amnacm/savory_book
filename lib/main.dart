import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savory_book/functions/db_function.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/meal_planner_model.dart';
import 'package:savory_book/model/user_model.dart';
import 'package:savory_book/screens/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';

final ValueNotifier<bool> themeNotifier = ValueNotifier(false);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(MealPlannerModelAdapter());

  await Hive.openBox<User>('userBox');
  await Hive.openBox<Food>('foodBox');
  await Hive.openBox<MealPlannerModel>('mealBox');
  await Hive.openBox('settingsBox');
   getUser(); 

 final settingsBox = Hive.box('settingsBox');
  themeNotifier.value = settingsBox.get('isDarkMode',defaultValue: false);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0x3C000000),
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: themeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: isDarkMode
              ? ThemeData.dark().copyWith(
                  textTheme: ThemeData.dark().textTheme.apply(
                      fontFamily: 'LeagueSpartan', bodyColor: Colors.white),
                  inputDecorationTheme: _inputDecorationBuilder(Colors.white),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                )
              : ThemeData.light().copyWith(
                  textTheme: ThemeData.light().textTheme.apply(
                      fontFamily: 'LeagueSpartan', bodyColor: Colors.black),
                  inputDecorationTheme:
                      _inputDecorationBuilder(const Color(0xFFD2AE95)),
                ),
          home: const Splashscreen(),
        );
      },
    );
  }

  static InputDecorationTheme _inputDecorationBuilder(Color color) {
    return InputDecorationTheme(
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
