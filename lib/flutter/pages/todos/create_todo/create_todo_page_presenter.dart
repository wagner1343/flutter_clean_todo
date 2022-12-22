import 'package:flutter/foundation.dart';

abstract class CreateTodoPagePresenter implements Listenable {
  Future<void> createTodo({required String title, required String description});

  bool get isCreating;

  void navigateBack();

  Stream<String?> get errorStream;
}
