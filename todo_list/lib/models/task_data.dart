import 'package:flutter/foundation.dart';
import 'task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'buy phone', isDone: false),
    Task(name: 'buy pc', isDone: false),
    Task(name: 'buy earphone', isDone: false)
  ];

  int get taskCount {
    return tasks.length;
  }
}
