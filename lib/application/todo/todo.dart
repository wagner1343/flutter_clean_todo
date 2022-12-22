import 'package:flutter_clean_todo/application/entity/entity.dart';

class Todo extends Entity {
  final String title;
  final String description;
  final bool isDone;

  Todo(
      {required super.id,
      required super.createdAt,
      required this.title,
      required this.description,
      required this.isDone});
}
