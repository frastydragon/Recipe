import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false, });
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();

  void addTask() {
    setState(() {
      if (taskController.text.isNotEmpty) {
        tasks.add(Task(name: taskController.text));
        taskController.clear();
      }
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(labelText: 'Enter task name'),
                  ),
                ),
                
                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: () {
                    addTask();
                    
                  },
                  child: Text('Add'),
                ),
              ],
            ),

            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        toggleTaskCompletion(index);
                      },
                    ),

                    title: Text(
                      task.name,
                      style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                   
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => removeTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}