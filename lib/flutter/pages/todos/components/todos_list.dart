import 'package:flutter/material.dart';
import 'package:flutter_clean_todo/application/todo/todo.dart';
import 'package:flutter_clean_todo/flutter/pages/todos/todos_page_presenter.dart';
import 'package:provider/provider.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  Widget _buildTodoTrailing(
      BuildContext context, Todo todo, TodosPagePresenter presenter) {
    final theme = Theme.of(context);
    return IconButton(
        color: todo.isDone ? null : theme.primaryColor,
        onPressed: presenter.isUpdatingTodo(todo)
            ? null
            : () => presenter.setTodoIsDone(todo: todo, isDone: !todo.isDone),
        icon:
            todo.isDone ? const Icon(Icons.restore) : const Icon(Icons.check));
  }

  Widget _buildTodo(
      BuildContext context, Todo todo, TodosPagePresenter presenter) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.horizontal,
      background: Container(
          alignment: Alignment.centerLeft,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )),
      secondaryBackground: Container(
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 26),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )),
      onDismissed: (_) => presenter.deleteTodo(todo),
      child: ListTile(
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: _buildTodoTrailing(context, todo, presenter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<TodosPagePresenter>(context);
    final todos = presenter.todos;
    final isLoading = presenter.isLoadingTodos;

    if (todos == null && isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (todos == null || todos.isEmpty) {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320),
          padding: const EdgeInsets.all(12),
          child: const Text(
              "You don't have any todos yet, create one by pressing 'add' button",
              textAlign: TextAlign.center),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (ctx, i) => _buildTodo(context, todos[i], presenter),
      itemCount: todos.length,
    );
  }
}
