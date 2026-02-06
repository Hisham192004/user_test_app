import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  int age;

  @HiveField(3)
  String imagePath;

  UserModel({
    required this.name,
    required this.phone,
    required this.age,
    required this.imagePath,
  });
}
