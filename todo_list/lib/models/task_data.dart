import 'package:flutter/foundation.dart';
import 'task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'buy phone', isDone: false),
    Task(name: 'buy pc', isDone: false),
    Task(name: 'buy earphone', isDone: false)
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  void addTask(String newTaskList) {
    final task = Task(isDone: false, name: newTaskList);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.getDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }
}
