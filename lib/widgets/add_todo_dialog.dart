import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_app_state.dart';

void showAddTodoDialog(BuildContext context) {
  var textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('新しいTodoを追加'),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Todoを入力してください',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                var appState = context.read<TodoAppState>();
                appState.addTodo(textController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('追加'),
          ),
        ],
      );
    },
  );
}
