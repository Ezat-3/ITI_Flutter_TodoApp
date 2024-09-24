import 'package:flutter/material.dart';

import 'task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final Function(List<TaskItem>) onTaskAdded;

  AddTaskBottomSheet({required this.onTaskAdded});

  @override
  _AddTaskBottomSheetState createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  List<TextEditingController> controllers = [TextEditingController()];
  List<TaskItem> newTasks = [TaskItem('')];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 600,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Text(
                  'Add Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: newTasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: 'Task ${index + 1}',
                              ),
                              controller: controllers[index],
                              onChanged: (value) {
                                newTasks[index].text = value;
                              },
                            ),
                            const SizedBox(height: 8),
                            if (index == newTasks.length - 1)
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    controllers.add(TextEditingController());
                                    newTasks.add(TaskItem(''));
                                  });
                                },
                                color: Colors.black,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          List<TaskItem> combinedTasks = newTasks
                              .where((task) => task.text.isNotEmpty)
                              .toList();
                          if (combinedTasks.isNotEmpty) {
                            widget.onTaskAdded(combinedTasks);
                          }

                          controllers.clear();
                          newTasks.clear();
                          controllers.add(TextEditingController());
                          newTasks.add(TaskItem(''));
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Confirm'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
