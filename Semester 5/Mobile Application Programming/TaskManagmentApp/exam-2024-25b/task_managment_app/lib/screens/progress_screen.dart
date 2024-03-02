import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task_managment_app/business_logic/connection_status_manager.dart';
import 'package:task_managment_app/business_logic/tasks_business_logic.dart';
import 'package:task_managment_app/data_access/models/task.dart';
import 'package:task_managment_app/widgets/task_info_widget.dart';
import 'package:task_managment_app/widgets/month_duration_widget.dart';

class ProgressPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final TaskBusinessLogic taskBusinessLogic;

  const ProgressPage(this.scaffoldMessengerKey, this.taskBusinessLogic,
      {super.key});

  factory ProgressPage.create(GlobalKey<ScaffoldMessengerState> key,
      TaskBusinessLogic taskBusinessLogic) {
    return ProgressPage(key, taskBusinessLogic);
  }

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<Task> tasks = [];
  List<Task> tasksInRange = [];
  List<String> months = [];
  List<double> durationsByMonth = [];

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
          "This page is unavailable due to the absence of an internet connection", 1);
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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Duration per month'),
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
                "Durations by task month",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: months.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MonthDurationWidget(
                      month: months[index],
                      duration: durationsByMonth[index],
                    ),
                  );
                },
              ),
            ),

          ],
        ),
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
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                  "This page is unavailable due to the absence of an internet connection",
                  1,
                );
                Navigator.pop(context);}
              break;
            case 2:
              if (!widget.taskBusinessLogic.hasNetwork) {
                openSnackbar(
                  "You cannot access this section while offline.",
                  1,
                );
                Navigator.pop(context);
              }else{
                Navigator.popAndPushNamed(context,"/top");}
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    // tasks = await widget.taskBusinessLogic.getTopTenMeals();
    var map = await widget.taskBusinessLogic.getDurationsByMonth();
    months = map.keys.toList();
    durationsByMonth = map.values.toList();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}
