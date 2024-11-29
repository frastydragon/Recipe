import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    if (user != null) {
      return TaskListScreen();
    } else {
      return LoginScreen();
    }
  }
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  AuthService() {
    _auth.authStateChanges().listen((user) {
      this.user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                await authService.signIn(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                await authService.signUp(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController taskController = TextEditingController();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  late DatabaseReference taskRef;
  late DatabaseReference subTaskRef;

  @override
  void initState() {
    super.initState();
    taskRef = database.ref('tasks');
    subTaskRef = database.ref('subTasks');
  }

  void _addTask() {
    if (taskController.text.isNotEmpty) {
      final taskId = taskRef.push().key;
      taskRef.child(taskId!).set({
        'name': taskController.text,
        'isCompleted': false,
      });
      taskController.clear();
    }
  }

  void _toggleTaskCompletion(String taskId, bool isCompleted) {
    taskRef.child(taskId).update({
      'isCompleted': !isCompleted,
    });
  }

  void _deleteTask(String taskId) {
    taskRef.child(taskId).remove();
  }

  void _addSubTask(String taskId, String subTaskName, String timeFrame) {
    final subTaskId = subTaskRef.push().key;
    subTaskRef.child(subTaskId!).set({
      'taskId': taskId,
      'name': subTaskName,
      'timeFrame': timeFrame,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              decoration: InputDecoration(labelText: 'Enter Task'),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: taskRef,
              itemBuilder: (context, snapshot, animation, index) {
                final task = snapshot.value as Map;
                final taskId = snapshot.key!;
                final taskName = task['name'];
                final isCompleted = task['isCompleted'] ?? false;

                return ListTile(
                  leading: Checkbox(
                    value: isCompleted,
                    onChanged: (value) {
                      _toggleTaskCompletion(taskId, isCompleted);
                    },
                  ),
                  title: Text(taskName),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteTask(taskId),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
