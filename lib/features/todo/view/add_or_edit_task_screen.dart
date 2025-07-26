import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/features/todo/controller/todo_controller.dart';
import 'package:to_do_app/features/todo/model/todo_model.dart';

class AddOrEditTaskScreen extends StatefulWidget {
  final TodoModel? todo;

  const AddOrEditTaskScreen({super.key, this.todo});

  @override
  State<AddOrEditTaskScreen> createState() => _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends State<AddOrEditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool get isEditing => widget.todo != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _titleController.text = widget.todo!.title;
      _descController.text = _cleanDescription(widget.todo!.description);
    }
  }

  String _cleanDescription(String desc) {
    // Remove all old timestamps and reminder info
    return desc
        .replaceAll(RegExp(r'🕒.*(\n)?'), '')
        .replaceAll(RegExp(r'⏰.*(\n)?'), '')
        .trim();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  Future<void> _saveTask() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty || desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields required")),
      );
      return;
    }

    final now = DateTime.now();

    // Optional: format reminder
    String reminderText = '';
    if (selectedDate != null && selectedTime != null) {
      final reminderDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      reminderText =
      "\n⏰ Reminder: ${DateFormat('yyyy-MM-dd HH:mm').format(reminderDateTime)}";
    }

    // Final cleaned description (no duplicate created time)
    final fullDescription =
        "$desc$reminderText"; // <- No extra 🕒 here

    final controller = context.read<TodoController>();

    if (isEditing) {
      final updatedTodo = TodoModel(
        id: widget.todo!.id,
        title: title,
        description: fullDescription,
        timestamp: now,

      );
      await controller.updateTodo(updatedTodo);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task Updated")),
      );
    } else {
      await controller.addTodo(title, fullDescription);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task Added")),
      );
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "EDIT TASK" : "ADD TASK",
          style: TextStyle(
            fontSize: 25,fontWeight: FontWeight.bold,
          ),),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                maxLines: 7,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        selectedDate == null
                            ? "Pick Date"
                            : DateFormat.yMMMd().format(selectedDate!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time),
                      label: Text(
                        selectedTime == null
                            ? "Pick Time"
                            : selectedTime!.format(context),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveTask,
                icon: Icon(isEditing ? Icons.edit : Icons.save,color: Colors.white,),
                label: Text(isEditing ? "Update Task" : "Save Task",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
