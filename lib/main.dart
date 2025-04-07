import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savory_book/model/food_model.dart';
import 'package:savory_book/model/user_model.dart';
import 'package:savory_book/screens/splash_screen.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FoodAdapter());

  await Hive.openBox<User>('userBox');
  await Hive.openBox<Food>('foodBox');

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Splashscreen(),
    );
  }
}
