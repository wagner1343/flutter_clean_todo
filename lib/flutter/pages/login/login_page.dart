import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/components/error_stream_to_snackbar.dart';
import 'package:flutter_clean_todo/flutter/pages/login/components/login_form.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page_presenter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final LoginPagePresenter _presenter;

  const LoginPage(this._presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<LoginPagePresenter>.value(
      value: _presenter,
      child: SafeArea(
        child: Scaffold(
          body: ErrorStreamToSnackbar(
              errorStream: _presenter.errorStream,
              child: Center(child: LoginForm())),
        ),
      ),
    );
  }
}
