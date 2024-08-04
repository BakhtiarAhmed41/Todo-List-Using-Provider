import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/model/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  List<Task> tasks = [];

  String? taskName;
  String? date;
  String? time;

  void setTaskName(String? value) {
    taskName = value;
  }

  void setDate(String? value) {
    date = value;
  }

  void setTime(String? value) {
    time = value;
  }

  void addTask() {
    if (taskName != null && date != null && time != null) {
      Task newTask = Task(taskName!, date!, time!);
      tasks.add(newTask);
      taskName = null;
      date = null;
      time = null;
      notifyListeners();
    }
  }
}
