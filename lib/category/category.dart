import 'package:hive/hive.dart';

part 'category.g.dart';
@HiveType(typeId: 2)
class Category1{
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String icon;

  Category1({required this.name, required this.icon});

  factory Category1.fromJson(Map<String, dynamic> json) {
    return Category1(
      name: json['name'],
      icon: json['icon'],
    );
  }
}