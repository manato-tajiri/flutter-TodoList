import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_repository.dart';

class TodoAppState extends ChangeNotifier {
  List<Todo> _todos = [];
  final TodoRepository _todoRepository = TodoRepository();
  bool _isLoading = false;

  // ローディング状態を取得
  bool get isLoading => _isLoading;

  // 全てのTodoを取得
  List<Todo> get todos {
    return _todos;
  }

  // 完了済みTodoを取得
  List<Todo> get completedTodos {
    return _todos.where((todo) => todo.isCompleted).toList();
  }

  // 未完了Todoを取得
  List<Todo> get incompleteTodos {
    return _todos.where((todo) => !todo.isCompleted).toList();
  }

  // データベースからTodoを読み込み
  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await _todoRepository.getAllTodos();
    } catch (e) {
      debugPrint('Todoの読み込みエラー: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Todoを追加
  Future<void> addTodo(String title) async {
    try {
      await _todoRepository.addTodo(title);
      await loadTodos(); // データを再読み込み
    } catch (e) {
      debugPrint('Todoの追加エラー: $e');
    }
  }

  // Todoの完了状態を切り替え
  Future<void> toggleTodo(String id) async {
    try {
      await _todoRepository.toggleTodo(id);
      await loadTodos(); // データを再読み込み
    } catch (e) {
      debugPrint('Todoの更新エラー: $e');
    }
  }

  // Todoを削除
  Future<void> deleteTodo(String id) async {
    try {
      await _todoRepository.deleteTodo(id);
      await loadTodos(); // データを再読み込み
    } catch (e) {
      debugPrint('Todoの削除エラー: $e');
    }
  }

  // リソースのクリーンアップ
  @override
  void dispose() {
    _todoRepository.closeDatabase();
    super.dispose();
  }
}
