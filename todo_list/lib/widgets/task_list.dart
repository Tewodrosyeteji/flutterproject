import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/task_tile.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [
    Task(name: 'buy phone', isDone: false),
    Task(name: 'buy pc', isDone: false),
    Task(name: 'buy earphone', isDone: false)
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        return TaskTile(
          isChecked: tasks[index].isDone,
          taskTitle: tasks[index].name,
          checkBoxCallBack: (checkBoxStatus) {
            setState(() {
              tasks[index].getDone();
            });
          },
        );
      }),
      itemCount: tasks.length,
    );
  }
}
