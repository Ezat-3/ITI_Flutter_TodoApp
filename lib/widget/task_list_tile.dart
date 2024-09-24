import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'task.dart';
import 'package:intl/intl.dart';

class TaskListTile extends StatefulWidget {
  final Task task;
  final Function(int) onDelete;
  final Function(int) onToggleCompletion;
  final VoidCallback onToggleExpansion;

  TaskListTile({
    required this.task,
    required this.onDelete,
    required this.onToggleCompletion,
    required this.onToggleExpansion,
  });

  @override
  _TaskListTileState createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${widget.task.time}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                icon: Icon(
                  widget.task.isExpanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onPressed: widget.onToggleExpansion,
              ),
            ],
          ),
          if (widget.task.isExpanded)
            Column(
              children: widget.task.items.asMap().entries.map((entry) {
                int itemIndex = entry.key;
                TaskItem taskItem = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Checkbox(
                        value: taskItem.isCompleted,
                        onChanged: (bool? value) {
                          widget.onToggleCompletion(itemIndex);
                        },
                        activeColor: Colors.green,
                      ),
                      title: Text(
                        taskItem.text,
                        style: TextStyle(
                          decoration: taskItem.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              _showEditBottomSheet(context, itemIndex);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              widget.onDelete(itemIndex);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context, int itemIndex) {
    TextEditingController _newTaskController = TextEditingController();

    String currentTime = DateFormat.jm().format(DateTime.now());

    List<TaskItem> tempTaskItems = List.from(widget.task.items);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Edit Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Time: $currentTime',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _newTaskController,
                        decoration:
                            const InputDecoration(labelText: 'New Task Name'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_newTaskController.text.isNotEmpty) {
                            setModalState(() {
                              tempTaskItems.add(TaskItem(
                                _newTaskController.text,
                                isCompleted: false,
                              ));
                              _newTaskController.clear();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: tempTaskItems.map((task) {
                          return ListTile(
                            title: Text(
                              task.text,
                              style: TextStyle(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.task.items = tempTaskItems;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 50),
                        ),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
