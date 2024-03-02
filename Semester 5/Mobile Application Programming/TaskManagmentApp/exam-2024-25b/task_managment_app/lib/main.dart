import 'package:flutter/material.dart';
import 'package:task_managment_app/business_logic/connection_status_manager.dart';
import 'package:task_managment_app/business_logic/tasks_business_logic.dart';
import 'package:task_managment_app/data_access/app_database.dart';
import 'package:task_managment_app/screens/home_page.dart';
import 'package:task_managment_app/screens/top_screen.dart';
// import 'package:task_managment_app/screens/profile_page.dart';
import 'package:task_managment_app/screens/progress_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  connectionStatus.initialize();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final mealBusinessLogic = TaskBusinessLogic(database.taskDao);
  runApp(MainApp(taskBusinessLogic: mealBusinessLogic));
}

class MainApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final TaskBusinessLogic taskBusinessLogic;

  MainApp({super.key, required this.taskBusinessLogic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            HomePage.create(scaffoldMessengerKey, taskBusinessLogic),
        // '/profile': (context) => ProfilePage.create(scaffoldMessengerKey),
        '/progress': (context) =>
            ProgressPage.create(scaffoldMessengerKey, taskBusinessLogic),
        '/top': (context) =>
            TopPage.create(scaffoldMessengerKey, taskBusinessLogic)
      },
    );
  }
}
