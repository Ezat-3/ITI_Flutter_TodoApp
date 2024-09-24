import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/todo_control.dart';
import '../models/todo_model.dart';
import '../widget/custom_icon.dart';
import '../widget/add_bottom_sheet.dart';
import '../widget/custom_panel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final TodoController todoController = TodoController();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffefefe),
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: Row(
                children: [
                  Text(
                    ' ${DateFormat.EEEE().format(DateTime.now())} , ${DateTime.now().day}, ${DateFormat.MMM().format(DateTime.now())} ${DateTime.now().year}',
                    style: const TextStyle(color: Colors.black45, fontSize: 28),
                  ),
                  const SizedBox(width: 23),
                  const Icon(Icons.calendar_today, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              Panel(
                task: TodoModel(
                  id: '1',
                  description: 'Flutter',
                ),
              ),
            ],
          ),
          CustomIconButton(
            color: Colors.black,
            text: '+ Add Task',
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => AddTaskBottomSheet());
            },
          ),
        ],
      ),
    );
  }
}
