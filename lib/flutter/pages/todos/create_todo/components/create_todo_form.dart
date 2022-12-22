import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/create_todo/create_todo_page_presenter.dart';
import 'package:provider/provider.dart';

class CreateTodoForm extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  CreateTodoForm({Key? key}) : super(key: key);

  Future<void> _createOnPressed(CreateTodoPagePresenter presenter) async {
    await presenter.createTodo(
        title: _titleController.text, description: _descriptionController.text);
  }

  void _backOnPressed(CreateTodoPagePresenter presenter) {
    presenter.navigateBack();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final presenter = Provider.of<CreateTodoPagePresenter>(context);

    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              "Create Todo",
              style: text.headline6,
            ),
          ),
          TextField(
            decoration: const InputDecoration(label: Text("Title")),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(label: Text("Description")),
            controller: _descriptionController,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => _backOnPressed(presenter),
                    child: const Text("Back")),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                    onPressed: presenter.isCreating
                        ? null
                        : () => _createOnPressed(presenter),
                    child: const Text("Create"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
