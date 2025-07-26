class TodoModel {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp; // <-- renamed field
  final bool isDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      timestamp: DateTime.parse(map['timestamp']), // updated
      isDone: map['isDone'] ?? false,
    );
  }
}
