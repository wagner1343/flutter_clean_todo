import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/pages/login/login_page_presenter.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginForm({Key? key}) : super(key: key);

  Future<void> _loginOnPressed(LoginPagePresenter presenter) async {
    await presenter.loginWithEmailAndPassword(
        _emailController.text, _passwordController.text);
  }

  void _registerOnPressed(LoginPagePresenter presenter) {
    presenter.navigateToRegisterPage();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final presenter = Provider.of<LoginPagePresenter>(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style: text.headline6,
          ),
          Container(
            height: 16,
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(label: Text("Email")),
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => _registerOnPressed(presenter),
                    child: const Text("Sign Up")),
                Container(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: presenter.isLoggingIn
                        ? null
                        : () => _loginOnPressed(presenter),
                    child: const Text("Login"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
