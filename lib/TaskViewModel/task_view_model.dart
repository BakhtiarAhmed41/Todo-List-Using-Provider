
import 'package:flutter/cupertino.dart';

import '../model/task_model.dart';

class TaskViewModel extends ChangeNotifier{

  List<Task> tasks = [];

  String? taskName;
  var dateController =  TextEditingController();
  var timeController =  TextEditingController();

  setTaskName(String? value){
    taskName = value;
    notifyListeners();
  }

  setDate(String? date){

  }

  setTime(String? time){

  }


  addTask(){

  }

}