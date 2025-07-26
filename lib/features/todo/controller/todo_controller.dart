import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../model/todo_model.dart';
import '../repo/todo_repo.dart';

class TodoController with ChangeNotifier {
  final _uuid = const Uuid();

  Stream<List<TodoModel>> get todos => TodoRepo.getTodos();

  Future<void> addTodo(String title, String description) async {
    final newTodo = TodoModel(
      id: _uuid.v4(),
      title: title,
      description: description,
      timestamp: DateTime.now(), // ✅ Updated here
    );
    await TodoRepo.addTodo(newTodo);
  }

  Future<void> deleteTodo(String id) => TodoRepo.deleteTodo(id);

  Future<void> updateTodo(TodoModel todo) => TodoRepo.updateTodo(todo);
}
