import 'package:hive_flutter/adapters.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? imagePath;

  @HiveField(3)
  final String password;

  User(
      {required this.name,
      required this.email,
      required this.password,
      this.imagePath});
}
