import 'package:flutter_clean_todo/application/todo/todo.dart';

abstract class TodosService {
  Stream<List<Todo>> listTodos();

  Future<void> deleteTodo(String todoId);

  Future<void> createTodo({required String title, required String description});

  Future<void> setIsDone({required String todoId, required bool isDone});
}
