import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/pages/register/register_page_presenter.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterForm({Key? key}) : super(key: key);

  Future<void> _registerOnPressed(RegisterPagePresenter presenter) async {
    presenter.registerWithEmailAndPassword(
        _nameController.text, _emailController.text, _passwordController.text);
  }

  void _backOnPressed(RegisterPagePresenter presenter) {
    presenter.navigateToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<RegisterPagePresenter>(context);
    final text = Theme.of(context).textTheme;

    return Container(
      constraints: BoxConstraints(maxWidth: 320),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sign Up", style: text.headline6),
          Container(
            height: 16,
          ),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(label: Text("Name")),
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
                    onPressed: () => _backOnPressed(presenter),
                    child: Text("Back")),
                Container(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: presenter.isRegistering
                        ? null
                        : () => _registerOnPressed(presenter),
                    child: const Text("Register"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
