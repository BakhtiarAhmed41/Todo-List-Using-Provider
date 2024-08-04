import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/TaskViewModel/task_view_model.dart';

import 'model/task_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    final tabs = [
      const TaskScreen(),
      const Completed(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) => Dialog(
              child: SizedBox(
                height: height * 0.6,
                width: width * 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Create New Task",
                      style: TextStyle(height: 5, fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: taskNameController,
                        decoration: InputDecoration(
                          hintText: "Enter your task",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        readOnly: true,
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: "Select a date",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month),
                            onPressed: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2027),
                              );
                              if (date != null) {
                                dateController.text = date.toLocal().toString().split(' ')[0];
                                context.read<TaskViewModel>().setDate(dateController.text);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        readOnly: true,
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: "Select time",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.timer),
                            onPressed: () async {
                              TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                timeController.text = time.format(context);
                                context.read<TaskViewModel>().setTime(timeController.text);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        child: const Text("Add task"),
                        onPressed: () {
                          final taskProvider = context.read<TaskViewModel>();
                          taskProvider.setTaskName(taskNameController.text);
                          taskProvider.addTask();

                          taskNameController.clear();
                          dateController.clear();
                          timeController.clear();
                          Navigator.pop(context); // Close the dialog
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: tabs[_currentIndex],
    );
  }
}

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Your Tasks",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, value, _) {
          return ListView.separated(
            itemBuilder: (context, index) {
              Task task = value.tasks[index];
              return ListTile(
                title: Text(task.taskName),
                subtitle: Row(
                  children: [
                    Text(task.date),
                    const SizedBox(width: 5),
                    Text(task.time),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
              );
            },
            itemCount: value.tasks.length,
          );
        },
      ),
    );
  }
}

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Completed Tasks",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
    );
  }
}
