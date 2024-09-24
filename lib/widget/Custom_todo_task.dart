import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoTask extends StatefulWidget {
  const TodoTask({super.key, required this.todo});
  final TodoModel todo;

  @override
  State<TodoTask> createState() => _TodoTaskState();
}

class _TodoTaskState extends State<TodoTask> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value1) {
                setState(() {});
                value = value1!;
              },
            ),
            Text(
              widget.todo.description,
              style: TextStyle(
                  decoration: value == true ? TextDecoration.lineThrough : null,
                  color: value == true ? Colors.grey : Colors.black,
                  fontSize: 20),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
