// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:todo_app/category/category.dart';

part 'todomodel.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final Category1 category;
  @HiveField(4)
  final int color;
  @HiveField(5)
  final bool isDone;
  @HiveField(6)
  bool isArchived;

  TodoModel({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.color,
    required this.isDone,
    required this.isArchived,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'color': color,
      'isDone': isDone,
      'isArchived': isArchived,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: Category1.fromJson(map['category'] as Map<String,dynamic>),
      color: map['color'] as int,
      isDone: map['isDone'] as bool,
      isArchived: map['isArchived'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
