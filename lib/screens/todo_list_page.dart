import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_app_state.dart';
import '../widgets/add_todo_dialog.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<TodoAppState>();
    var incompleteTodos = appState.incompleteTodos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo一覧'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: appState.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : incompleteTodos.isEmpty
              ? Center(
                  child: Text(
                    'Todoがありません\n下のボタンで追加してください',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: incompleteTodos.length,
                  itemBuilder: (context, index) {
                    var todo = incompleteTodos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (bool? value) {
                          appState.toggleTodo(todo.id);
                        },
                      ),
                      title: Text(todo.title),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          appState.deleteTodo(todo.id);
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTodoDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
