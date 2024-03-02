import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_managment_app/business_logic/connection_status_manager.dart';
import 'package:task_managment_app/business_logic/tasks_business_logic.dart';
import 'package:task_managment_app/data_access/models/task.dart';
import 'package:task_managment_app/widgets/task_top_widget.dart';
import 'package:task_managment_app/widgets/month_duration_widget.dart';

class TopPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final TaskBusinessLogic taskBusinessLogic;

  const TopPage(this.scaffoldMessengerKey, this.taskBusinessLogic,
      {super.key});

  factory TopPage.create(GlobalKey<ScaffoldMessengerState> key,
      TaskBusinessLogic taskBusinessLogic) {
    return TopPage(key, taskBusinessLogic);
  }

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<List<String>> topCategories = [];
  List<Task> tasksInRange = [];
  // List<String> types = [];
  // List<double> caloriesByType = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus =
    ConnectionStatusManager.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (mounted && !hasNetwork) {
      openSnackbar(
          "This page is unavailable due to absence of internet connection", 1);
      Navigator.pop(context);
    }
  }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 3 categories'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text(
                    "Top 3 categories by duration",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: topCategories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TaskTopWidget(category: topCategories[index][0],nrTasks:topCategories[index][1])),
                          ],
                        );
                      },
                    )),
                // const Divider(),

              ])),
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
        currentIndex: 2,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                    "This page is unavailable due to absence of internet connection",
                    1);
              } else {
                Navigator.popAndPushNamed(context, "/progress");
              }
              break;
            case 2:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
                Navigator.pop(context);
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    topCategories = await widget.taskBusinessLogic.getTopThreeCategoriesWithTaskCount();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}