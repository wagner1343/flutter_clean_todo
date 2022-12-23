import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/components/error_stream_to_snackbar.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/components/create_todo_form.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page_presenter.dart';
import 'package:provider/provider.dart';

class CreateTodoPage extends StatelessWidget {
  final CreateTodoPagePresenter _presenter;

  const CreateTodoPage(this._presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider.value(
      value: _presenter,
      child: SafeArea(
        child: Scaffold(
          body: ErrorStreamToSnackbar(
            errorStream: _presenter.errorStream,
            child: Center(
              child: CreateTodoForm(),
            ),
          ),
        ),
      ),
    );
  }
}
