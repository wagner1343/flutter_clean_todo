import 'package:flutter_clean_todo/application/todo/todos_service.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page_presenter.dart';
import 'package:flutter_clean_todo/infra/getx/presenters/stream_subscription_manager.dart';
import 'package:get/get.dart';

class GetxCreateTodoPresenter extends GetxController
    with StreamSubscriptionManager
    implements CreateTodoPagePresenter {
  final TodosService _todosService;
  final RxBool _isCreatingRx = RxBool(false);
  final Rx<String?> _errorRx = Rx(null);

  GetxCreateTodoPresenter(this._todosService) {
    addStreamList([
      _isCreatingRx.stream,
    ]);
  }

  @override
  Future<void> createTodo(
      {required String title, required String description}) async {
    try {
      _isCreatingRx.value = true;
      _errorRx.value = null;
      await _todosService.createTodo(title: title, description: description);
      Get.back();
    } catch (e, s) {
      print(e);
      print(s);
      _errorRx.value = "Something went wrong creating your todo";
    } finally {
      _isCreatingRx.value = false;
    }
  }

  @override
  bool get isCreating => _isCreatingRx.value;

  @override
  void navigateBack() {
    Get.back();
  }

  @override
  Stream<String?> get errorStream => _errorRx.stream;

  @override
  void dispose() {
    clearSubscriptions();
    super.dispose();
  }
}
