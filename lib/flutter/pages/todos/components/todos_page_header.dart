import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page_presenter.dart';
import 'package:provider/provider.dart';

class TodosPageHeader extends StatelessWidget {
  const TodosPageHeader({Key? key}) : super(key: key);

  void _addTodoOnPressed(TodosPagePresenter presenter) {
    presenter.navigateToAddTodoPage();
  }

  void _signOutOnPressed(TodosPagePresenter presenter) {
    presenter.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final presenter = Provider.of<TodosPagePresenter>(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24, top: 12),
            child: Row(
              children: [
                Text(
                  "Hello, ${presenter.userDisplayName ?? "User"}",
                  style: text.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextButton.icon(
                    onPressed: () => _signOutOnPressed(presenter),
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 18,
                    ),
                    label: const Text("Sign Out"),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "Your Todos",
                      style: text.headline6,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () => _addTodoOnPressed(presenter),
                label: const Text("Add"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
