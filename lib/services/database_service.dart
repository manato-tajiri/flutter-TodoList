import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/todo.dart';

class DatabaseService {
  static Database? _database;
  static const String _tableName = 'todos';

  // シングルトンパターンでデータベースインスタンスを取得
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  // データベースの初期化
  Future<Database> _initDatabase() async {
    // デスクトップ環境の場合はFFIを初期化
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    // データベースファイルのパスを取得
    String path = join(await getDatabasesPath(), 'todo_database.db');

    // データベースを開く（存在しない場合は作成）
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  // テーブルの作成
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        isCompleted INTEGER NOT NULL,
        createdAt INTEGER NOT NULL
      )
    ''');
  }

  // 全てのTodoを取得
  Future<List<Todo>> getAllTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'createdAt DESC',
    );

    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  // Todoを挿入
  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      _tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Todoを更新
  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    await db.update(
      _tableName,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Todoを削除
  Future<void> deleteTodo(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // データベースを閉じる
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
