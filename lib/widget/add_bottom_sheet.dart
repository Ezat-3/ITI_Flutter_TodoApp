import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_list/widget/custom_icon.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var selectedTime;
  final textController = TextEditingController();
  final List<String> taskList = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add Task',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Time : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          final now = DateTime.now();
                          setState(() {
                            selectedTime = DateTime(now.year, now.month,
                                now.day, pickedTime.hour, pickedTime.minute);
                          });
                        }
                      },
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.black54,
                      // ),
                      child: Text(
                        selectedTime == null
                            ? 'Select Time'
                            : DateFormat.jm().format(selectedTime!),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (textController.text.isNotEmpty) {
                    setState(() {
                      taskList.add(textController.text);
                      textController.clear();
                    });
                  }
                },
                child: const Icon(
                  Icons.add,
                  size: 25,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.black, width: 1.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              taskList[index],
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              CustomIconButton(
                color: Colors.black,
                text: 'Confirm',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
