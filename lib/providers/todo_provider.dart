import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../api/todo_api.dart';

class TodoProvider extends ChangeNotifier {
  final TodoApi _api;
  List<Todo> _todos = [];
  bool _loading = false;

  TodoProvider(this._api);

  List<Todo> get todos => _todos;
  bool get loading => _loading;

  Future<void> loadTodos() async {
    _loading = true;
    notifyListeners();

    try {
      _todos = await _api.getTodos();
    } catch (_) {}
    _loading = false;
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    try {
      final created = await _api.createTodo(todo);
      _todos.insert(0, created);
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    try {
      final updated = todo.copyWith(isCompleted: !todo.isCompleted);
      await _api.updateTodo(todo.id ?? '', updated);

      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = updated;
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      await _api.deleteTodo(todo.id ?? '');
      _todos.removeWhere((t) => t.id == todo.id);
      notifyListeners();
    } catch (_) {}
  }
}
