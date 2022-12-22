import 'package:flutter/foundation.dart';
import 'package:flutter_clean_todo/application/todo/todo.dart';

abstract class TodosPagePresenter implements Listenable {
  List<Todo>? get todos;

  bool get isLoadingTodos;

  Future<void> loadTodos();

  Future<void> deleteTodo(Todo todo);

  Future<void> setTodoIsDone({required Todo todo, required bool isDone});

  bool isUpdatingTodo(Todo todo);

  Stream<String?> get errorStream;

  void navigateToAddTodoPage();

  void signOut();

  String? get userDisplayName;
}
