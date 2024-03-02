import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fitness_app/business_logic/connection_status_manager.dart';
import 'package:fitness_app/business_logic/meals_business_logic.dart';
import 'package:fitness_app/data_access/models/meal.dart';
import 'package:fitness_app/widgets/meal_history_widget.dart';
import 'package:fitness_app/widgets/meal_info_widget.dart';
import 'package:fitness_app/widgets/type_calorie_intake_widget.dart';

class ReportsPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final MealBusinessLogic mealBusinessLogic;

  const ReportsPage(this.scaffoldMessengerKey, this.mealBusinessLogic,
      {super.key});

  factory ReportsPage.create(GlobalKey<ScaffoldMessengerState> key,
      MealBusinessLogic mealBusinessLogic) {
    return ReportsPage(key, mealBusinessLogic);
  }

  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<Meal> meals = [];
  List<Meal> mealsInRange = [];
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
        title: const Text('Reports'),
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
                "Top 10 Meals by calories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 280.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MealInfoWidget(meal: meals[index]),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 5.0),
              child: Text(
                "Calories intake by meal type",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: types.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TypeCalorieIntakeWidget(
                      type: types[index],
                      calories: caloriesByType[index],
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            MealHistoryWidget(meals: widget.mealBusinessLogic.meals),
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
              if (!widget.mealBusinessLogic.hasNetwork) {
                openSnackbar(
                  "This page is unavailable due to the absence of an internet connection",
                  1,
                );
              } else {
                Navigator.popAndPushNamed(context, "/manage");
              }
              break;
            case 2:
              if (!widget.mealBusinessLogic.hasNetwork) {
                openSnackbar(
                  "You cannot access this section while offline.",
                  1,
                );
                Navigator.pop(context);
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    meals = await widget.mealBusinessLogic.getTopTenMeals();
    var map = widget.mealBusinessLogic.getCaloriesByType();
    types = map.keys.toList();
    caloriesByType = map.values.toList();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}
