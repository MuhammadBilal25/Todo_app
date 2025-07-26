import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo_model.dart';

class TodoRepo {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addTodo(TodoModel todo) async {
    await _db.collection("todos").doc(todo.id).set(todo.toMap());
  }

  static Future<void> deleteTodo(String id) async {
    await _db.collection("todos").doc(id).delete();
  }

  static Future<void> updateTodo(TodoModel todo) async {
    await _db.collection("todos").doc(todo.id).update(todo.toMap());
  }

  static Stream<List<TodoModel>> getTodos() {
    return _db.collection("todos").snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();

        // Handle both 'timestamp' and 'createdAt' for compatibility
        if (!data.containsKey('timestamp') && data.containsKey('createdAt')) {
          data['timestamp'] = data['createdAt'];
        }

        return TodoModel.fromMap(data);
      }).toList(),
    );
  }
}
