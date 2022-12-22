import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/components/error_stream_to_snackbar.dart';
import 'package:flutter_clean_todo/flutter/pages/register/components/register_form.dart';
import 'package:provider/provider.dart';

import 'register_page_presenter.dart';

class RegisterPage extends StatelessWidget {
  final RegisterPagePresenter _presenter;

  const RegisterPage(this._presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<RegisterPagePresenter>.value(
      value: _presenter,
      child: SafeArea(
        child: Scaffold(
          body: ErrorStreamToSnackbar(
            errorStream: _presenter.errorStream,
            child: Center(
              child: RegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}
