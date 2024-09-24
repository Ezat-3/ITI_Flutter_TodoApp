import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo_model.dart';
import 'Custom_todo_task.dart';

class Panel extends StatelessWidget {
  const Panel({super.key, required this.task});
  final TodoModel task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.lightBlue[400]!, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              Text(
                DateFormat.jm().format(DateTime.now()),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          children: [
            TodoTask(
              todo: TodoModel(id: task.id, description: task.description),
            ),
          ],
        ),
      ),
    );
  }
}
