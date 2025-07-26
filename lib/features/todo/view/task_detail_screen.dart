import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/features/todo/model/todo_model.dart';
import 'add_or_edit_task_screen.dart'; // ← Update if needed

class TaskDetailScreen extends StatelessWidget {
  final TodoModel todo;

  const TaskDetailScreen({super.key, required this.todo});

  String _cleanDescription(String desc) {
    return desc.replaceAll(RegExp(r'🕒 Created:.*(\n)?'), '').trim();
  }

  String _extractReminder(String desc) {
    final match = RegExp(r'⏰ Reminder: (.*)').firstMatch(desc);
    return match != null ? match.group(1)! : "";
  }

  @override
  Widget build(BuildContext context) {
    final cleanedDesc = _cleanDescription(todo.description);
    final reminder = _extractReminder(todo.description);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(

        title: const Text("TASK DETAIL",style: TextStyle( fontSize: 25,fontWeight: FontWeight.bold,), ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddOrEditTaskScreen(todo: todo),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  cleanedDesc,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (reminder.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.alarm, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Text(
                    reminder,
                    style: const TextStyle(fontSize: 15, color: Colors.redAccent),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            Row(
              children: [
                const Icon(Icons.update, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Last Updated: ${DateFormat.yMMMd().add_jm().format(todo.timestamp)}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
