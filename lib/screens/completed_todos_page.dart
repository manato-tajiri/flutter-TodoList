import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_app_state.dart';

class CompletedTodosPage extends StatelessWidget {
  const CompletedTodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<TodoAppState>();
    var completedTodos = appState.completedTodos;

    return Scaffold(
      appBar: AppBar(
        title: Text('完了済みTodo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: appState.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : completedTodos.isEmpty
              ? Center(
                  child: Text(
                    '完了済みのTodoがありません',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: completedTodos.length,
                  itemBuilder: (context, index) {
                    var todo = completedTodos[index];
                    return ListTile(
                      leading: Icon(Icons.check_circle, color: Colors.green),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          appState.deleteTodo(todo.id);
                        },
                      ),
                      onTap: () {
                        appState.toggleTodo(todo.id);
                      },
                    );
                  },
                ),
    );
  }
}
