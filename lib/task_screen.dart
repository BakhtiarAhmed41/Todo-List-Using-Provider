import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
  final tabs = [
    Tasks(),
    Completed()
  ];
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Tasks"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done),
              label: "Completed"
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      body: tabs[_currentIndex],
    );
  }
}




class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Your Tasks", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView.separated(itemBuilder: (context, index) {
        return ListTile(
          title: Text("Task ${index+1}"),
        );

      },
          separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
              );
      },
          itemCount: 5),
    );
  }
}





class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Completed Tasks", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
    );
  }
}
