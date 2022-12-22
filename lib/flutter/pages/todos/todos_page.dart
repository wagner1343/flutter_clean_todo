import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/components/error_stream_to_snackbar.dart';
import 'package:flutter_clean_todo/flutter/components/post_frame_callback.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/components/todos_list.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/components/todos_page_header.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page_presenter.dart';
import 'package:provider/provider.dart';

class TodosPage extends StatelessWidget {
  final TodosPagePresenter _presenter;

  const TodosPage(this._presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<TodosPagePresenter>.value(
      value: _presenter,
      child: SafeArea(
        child: PostFrameCallback(
          callback: (_) => _presenter.loadTodos(),
          child: ErrorStreamToSnackbar(
            errorStream: _presenter.errorStream,
            child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TodosPageHeader(),
                  //TodosList()
                  Expanded(child: TodosList())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
