import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitnessapp/business_logic/connection_status_manager.dart';
import 'package:fitnessapp/business_logic/workouts_business_logic.dart';
import 'package:fitnessapp/data_access/models/workout.dart';
import 'package:fitnessapp/widgets/workout_history_widget.dart';
import 'package:fitnessapp/widgets/workout_info_widget.dart';
import 'package:fitnessapp/widgets/type_calorie_intake_widget.dart';

class ReportsPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final WorkoutBusinessLogic workoutBusinessLogic;

  const ReportsPage(this.scaffoldMessengerKey, this.workoutBusinessLogic,
      {super.key});

  factory ReportsPage.create(GlobalKey<ScaffoldMessengerState> key,
      WorkoutBusinessLogic workoutBusinessLogic) {
    return ReportsPage(key, workoutBusinessLogic);
  }

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<Workout> workouts = [];
  List<Workout> workoutsInRange = [];
  List<String> types = [];
  List<double> caloriesByType = [];

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
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 5.0),
                  child: Text(
                    "Top 10 Workouts by calories",
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                    height: 280.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: workouts.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: WorkoutInfoWidget(workout: workouts[index])),
                          ],
                        );
                      },
                    )),
                const Divider(),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Text(
                          "Calories intake by workout type",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                          height: 180.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: types.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TypeCalorieIntakeWidget(
                                          type: types[index],
                                          calories: caloriesByType[index])),
                                ],
                              );
                            },
                          )),
                      const Divider(),
                      WorkoutHistoryWidget(workouts: widget.workoutBusinessLogic.workouts)
                    ])
              ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: 'Manage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration),
            label: 'Reports',
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
              if (!widget.workoutBusinessLogic.hasNetwork) {
                openSnackbar(
                    "This page is unavailable due to absence of internet connection",
                    1);
              } else {
                Navigator.popAndPushNamed(context, "/manage");
              }
              break;
            case 2:
              if (!widget.workoutBusinessLogic.hasNetwork) {
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
    workouts = await widget.workoutBusinessLogic.getTopTenWorkouts();
    var map = widget.workoutBusinessLogic.getCaloriesByType();
    types = map.keys.toList();
    caloriesByType = map.values.toList();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}