// dependencies:
//   flutter:
//     sdk: flutter
//   http: ^1.1.0


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TodoListScreen(),
    );
  }
}
class Todo {
  final int? id;
  String title;
  bool isCompleted;

  Todo({this.id, required this.title, this.isCompleted = false});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['completed'] ?? false,
    );
  }
  Map<String, dynamic> toJson() => {'title': title, 'completed': isCompleted};
}
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/todos';
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?_limit=10'));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        setState(() {
          _todos = data.map((item) => Todo.fromJson(item)).toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      _showError("Could not load tasks");
    }
  }
  Future<void> _addTodo(String title) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'completed': false}),
      );

      if (response.statusCode == 201) {
        setState(() {
          _todos.insert(0, Todo(id: _todos.length + 1, title: title));
        });
      }
    } catch (e) {
      _showError("Failed to add task");
    }
  }
  Future<void> _toggleTodo(Todo todo) async {
    setState(() {
      todo.isCompleted = !todo.isCompleted;
    });
    try {
      await http.put(
        Uri.parse('$apiUrl/${todo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo.toJson()),
      );
    } catch (e) {
      _showError("Update failed on server");
    }
  }
  Future<void> _deleteTodo(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$id'));
      if (response.statusCode == 200) {
        setState(() {
          _todos.removeWhere((t) => t.id == id);
        });
      }
    } catch (e) {
      _showError("Could not delete");
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter CRUD TODO'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => _toggleTodo(todo),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _deleteTodo(todo.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayAddDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayAddDialog() async {
    final controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Enter task name"),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _addTodo(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

}
