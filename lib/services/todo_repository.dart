import '../models/todo.dart';
import 'database_service.dart';

class TodoRepository {
  final DatabaseService _databaseService = DatabaseService();

  // 全てのTodoを取得
  Future<List<Todo>> getAllTodos() async {
    return await _databaseService.getAllTodos();
  }

  // 完了済みTodoを取得
  Future<List<Todo>> getCompletedTodos() async {
    final allTodos = await getAllTodos();
    return allTodos.where((todo) => todo.isCompleted).toList();
  }

  // 未完了Todoを取得
  Future<List<Todo>> getIncompleteTodos() async {
    final allTodos = await getAllTodos();
    return allTodos.where((todo) => !todo.isCompleted).toList();
  }

  // Todoを追加
  Future<void> addTodo(String title) async {
    final todo = Todo(title: title);
    await _databaseService.insertTodo(todo);
  }

  // Todoの完了状態を切り替え
  Future<void> toggleTodo(String id) async {
    final allTodos = await getAllTodos();
    final todoIndex = allTodos.indexWhere((todo) => todo.id == id);
    
    if (todoIndex != -1) {
      final todo = allTodos[todoIndex];
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      await _databaseService.updateTodo(updatedTodo);
    }
  }

  // Todoを削除
  Future<void> deleteTodo(String id) async {
    await _databaseService.deleteTodo(id);
  }

  // データベースを閉じる
  Future<void> closeDatabase() async {
    await _databaseService.closeDatabase();
  }
}
