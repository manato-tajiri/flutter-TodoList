import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_app_state.dart';
import 'screens/todo_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoAppState(),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const AppInitializer(),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    // アプリ起動時にTodoデータを読み込み
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoAppState>().loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const TodoHomePage();
  }
}
