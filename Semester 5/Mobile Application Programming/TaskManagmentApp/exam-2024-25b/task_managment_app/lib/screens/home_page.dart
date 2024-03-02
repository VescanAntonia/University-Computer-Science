import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_managment_app/business_logic/connection_status_manager.dart';
import 'package:task_managment_app/business_logic/tasks_business_logic.dart';
import 'package:task_managment_app/business_logic/web_socket_manager.dart';
import 'package:task_managment_app/screens/add_task_page.dart';
import 'package:task_managment_app/screens/task_details_screen.dart';
import 'package:task_managment_app/widgets/task_list_widget.dart';

import '../data_access/models/task.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final TaskBusinessLogic taskBusinessLogic;

  const HomePage(this.scaffoldMessengerKey, this.taskBusinessLogic,
      {super.key});

  factory HomePage.create(GlobalKey<ScaffoldMessengerState> key,
      TaskBusinessLogic taskBusinessLogic) {
    return HomePage(key, taskBusinessLogic);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Task> tasksByDate=[];

  @override
  void initState() {
    super.initState();

    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    connectionStatus.hasNetwork();
  }

  @override
  void dispose() {
    _webSocketManager?.disconnect();
    ConnectionStatusManager.getInstance().dispose();
    widget.taskBusinessLogic.updateTasks();
    super.dispose();
  }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (!widget.taskBusinessLogic.hasNetwork && hasNetwork) {
      openSnackbar(
          "You are connected to internet. Your application has been updated with the server.",
          2);
      _webSocketManager = WebSocketManager(onMessageReceived: (remoteMeal) {
        var task = widget.taskBusinessLogic.addRemoteTask(remoteMeal);
        var message =
            "A new task was added. Type: ${task.type}, priority: ${task.priority}, category: ${task.category}";
        openSnackbar('Notification: $message', 2);
      });
      widget.taskBusinessLogic.hasNetwork = true;
    } else if (!hasNetwork) {
      openSnackbar(
          "There is no connection to internet! Loaded from local database.", 2);
      _webSocketManager?.disconnect();
      _webSocketManager = null;
      widget.taskBusinessLogic.hasNetwork = false;
      widget.taskBusinessLogic.saveTasks();
    }
    fetchData();
  }

  void addTask(DateTime date,String type, double duration, String priority,String category,
      String description) async {
    await widget.taskBusinessLogic
        .addTask(date, type, duration, priority, category,description)
        .then((_) {
      setState(() {});
      widget.taskBusinessLogic.syncLocalDbWithServer();
    }).catchError((e) {
      print('Error adding task: $e');
      openSnackbar("Error adding task: $e", 2);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.person),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/profile');
        //     },
        //   ),
        // ],
      ),
      body: _loading || widget.taskBusinessLogic.tasksDays.isEmpty
          ? Center(
          child: Column(children: [
            const CircularProgressIndicator(),
            const Text("Waiting for internet connection"),
            ElevatedButton(
                onPressed: () => connectionStatus.hasNetwork(),
                child: const Text("Retry connection"))
          ]))
          : TaskListWidget(taskDates: widget.taskBusinessLogic.tasksDays,onDateSelected:(selectedDate){
            fetchTasksByDate(selectedDate);
            Navigator.push(context,MaterialPageRoute(builder: (context)=>TaskDetailsScreen(selectedDate:selectedDate,tasks:tasksByDate,taskBusinessLogic: widget.taskBusinessLogic),),);
    },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddTaskPage(onSave: addTask)),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration),
            label: 'Top',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 1:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Future pushNamed = Navigator.pushNamed(context, '/progress');
                pushNamed.then((_) => setState(() {}));
              }
              break;
            case 2:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Navigator.pushNamed(context, '/top');
              }
              break;

          }
        },
      ),
    );
  }
  void fetchTasksByDate(String selectedDate) async {
    List<Task> tasks = await widget.taskBusinessLogic.getTasksByDate(selectedDate);
    setState(() {
      tasksByDate = tasks;
    });
  }

  fetchData() async {
    await widget.taskBusinessLogic.syncLocalDbWithServer();
    await widget.taskBusinessLogic.getAllTasksDays();
    setState(() {
      _loading = false;
    });
  }
}