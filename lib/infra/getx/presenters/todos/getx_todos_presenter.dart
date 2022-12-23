import 'dart:async';

import 'package:flutter_clean_todo/application/auth/auth_service.dart';
import 'package:flutter_clean_todo/application/todo/todo.dart';
import 'package:flutter_clean_todo/application/todo/todos_service.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/stream_subscription_manager.dart';
import 'package:get/get.dart';

class GetxTodoPresenter extends GetxController
    with StreamSubscriptionManager
    implements TodosPagePresenter {
  final TodosService _todosService;
  final AuthService _authService;

  final RxBool _isLoadingTodosRx = RxBool(false);
  final Rx<String?> _errorStreamRx = Rx(null);
  final Rx<List<Todo>?> _todosRx = Rx(null);
  final Rx<Map<String, bool>> _isUpdatingTodoMap = Rx({});

  StreamSubscription? _listTodosSub;

  GetxTodoPresenter(this._todosService, this._authService) {
    addStreamList([
      _isLoadingTodosRx.stream,
      _errorStreamRx.stream,
      _todosRx.stream,
      _isUpdatingTodoMap.stream,
      _authService.currentUserStream
    ]);
  }

  void _setIsUpdatingTodo(String todoId, bool isUpdating) {
    _isUpdatingTodoMap.value = {
      ..._isUpdatingTodoMap.value,
      todoId: isUpdating
    };
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    try {
      _setIsUpdatingTodo(todo.id, true);
      _todosRx.value = [..._todosRx.value ?? []]
        ..removeWhere((t) => t.id == todo.id);
      await _todosService.deleteTodo(todo.id);
    } catch (e, s) {
      print(e);
      print(s);
      _errorStreamRx.value =
          "Something went wrong trying to delete todo ${todo.id}";
    } finally {
      _setIsUpdatingTodo(todo.id, false);
    }
  }

  @override
  bool get isLoadingTodos => _isLoadingTodosRx.value;

  @override
  List<Todo>? get todos => _todosRx.value;

  @override
  bool isUpdatingTodo(Todo todo) {
    return _isUpdatingTodoMap.value[todo.id] ?? false;
  }

  @override
  Stream<String?> get errorStream => _errorStreamRx.stream;

  void _onTodosList(List<Todo> todosList) {
    _todosRx.value = todosList;
    _isLoadingTodosRx.value = false;
  }

  void _onTodosListError(Object e, StackTrace s) {
    print(e);
    print(s);
    _errorStreamRx.value = "Something went wrong trying to load todos list";
    _isLoadingTodosRx.value = false;
  }

  @override
  Future<void> loadTodos() async {
    await _listTodosSub?.cancel();
    _isLoadingTodosRx.value = true;
    _listTodosSub = _todosService
        .listTodos()
        .listen(_onTodosList, onError: _onTodosListError);
  }

  @override
  void dispose() {
    _listTodosSub?.cancel();
    clearSubscriptions();
    super.dispose();
  }

  @override
  void navigateToAddTodoPage() {
    Get.toNamed("/todos/create");
  }

  @override
  void signOut() {
    _authService.signOut();
  }

  @override
  String? get userDisplayName => _authService.currentUser?.name;

  @override
  Future<void> setTodoIsDone({required Todo todo, required bool isDone}) async {
    try {
      _setIsUpdatingTodo(todo.id, true);
      await _todosService.setIsDone(todoId: todo.id, isDone: isDone);
    } catch (e, s) {
      print(e);
      print(s);
      _errorStreamRx.value = "Something went wrong updating your todo";
    } finally {
      _setIsUpdatingTodo(todo.id, false);
    }
  }
}
