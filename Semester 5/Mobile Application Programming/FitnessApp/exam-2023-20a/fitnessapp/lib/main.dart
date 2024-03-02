import 'package:flutter/material.dart';
import 'package:fitnessapp/business_logic/connection_status_manager.dart';
import 'package:fitnessapp/business_logic/workouts_business_logic.dart';
import 'package:fitnessapp/data_access/app_database.dart';
import 'package:fitnessapp/screens/home_page.dart';
import 'package:fitnessapp/screens/manage_page.dart';
import 'package:fitnessapp/screens/profile_page.dart';
import 'package:fitnessapp/screens/reports_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  connectionStatus.initialize();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final mealBusinessLogic = WorkoutBusinessLogic(database.workoutDao);
  runApp(MainApp(mealBusinessLogic: mealBusinessLogic));
}

class MainApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final WorkoutBusinessLogic mealBusinessLogic;

  MainApp({super.key, required this.mealBusinessLogic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            HomePage.create(scaffoldMessengerKey, mealBusinessLogic),
        '/profile': (context) => ProfilePage.create(scaffoldMessengerKey),
        '/manage': (context) =>
            ManagePage.create(scaffoldMessengerKey, mealBusinessLogic),
        '/reports': (context) =>
            ReportsPage.create(scaffoldMessengerKey, mealBusinessLogic)
      },
    );
  }
}
