import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitnessapp/business_logic/connection_status_manager.dart';
import 'package:fitnessapp/business_logic/workouts_business_logic.dart';
import 'package:fitnessapp/data_access/models/workout.dart';
import 'package:fitnessapp/widgets/delete_confirmation_modal.dart';
import 'package:fitnessapp/widgets/workout_info_widget.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ManagePage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final WorkoutBusinessLogic workoutBusinessLogic;

  const ManagePage(this.scaffoldMessengerKey, this.workoutBusinessLogic,
      {super.key});

  factory ManagePage.create(GlobalKey<ScaffoldMessengerState> key,
      WorkoutBusinessLogic mealBusinessLogic) {
    return ManagePage(key, mealBusinessLogic);
  }

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<String> types = [];
  List<List<Workout>> workoutsByType = [];

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

  void deleteWorkout(int index, int workoutIndex) async {
    var meal = workoutsByType[index].removeAt(workoutIndex);
    if (workoutsByType[index].isEmpty) {
      workoutsByType.removeAt(index);
      types.removeAt(index);
    }
    await widget.workoutBusinessLogic
        .deleteMeal(_getIndexFromMeals(meal))
        .then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error deleting saving: $e');
      openSnackbar('Error deleting saving: $e', 2);
    });
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, int mealIndex) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onConfirm: () async {
            ProgressDialog pr = ProgressDialog(context);
            pr.style(message: 'Loading...');

            await pr.show();
            deleteWorkout(index, mealIndex);

            await pr.hide().then((_) => Navigator.pop(context));
          },
        );
      },
    );
  }

  int _getIndexFromMeals(Workout m) {
    return widget.workoutBusinessLogic.workouts
        .map((e) => e.id)
        .toList()
        .indexOf(m.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage workouts'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: types.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  types[index],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 260.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: workoutsByType[index].length,
                  itemBuilder: (context, mealIndex) {
                    return WorkoutInfoWidget(
                        workout: workoutsByType[index][mealIndex],
                        onDelete: () => _showDeleteConfirmationDialog(
                            context, index, mealIndex),
                        isDeleteEnabled: true);
                  },
                ),
              ),
            ],
          );
        },
      ),
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
        currentIndex: 1,
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
                Navigator.pop(context);
              }
              break;
            case 2:
              if (!widget.workoutBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
                Navigator.pop(context);
              } else {
                Navigator.popAndPushNamed(context, "/reports");
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    types = await widget.workoutBusinessLogic.getAllTypes();
    await fetchMealsForTypes();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }

  fetchMealsForTypes() async {
    for (var type in types) {
      workoutsByType.add(await widget.workoutBusinessLogic.getWorkoutsByType(type));
    }
  }
}