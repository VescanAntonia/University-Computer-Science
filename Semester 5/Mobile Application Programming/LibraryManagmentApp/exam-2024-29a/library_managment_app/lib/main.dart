import 'package:flutter/material.dart';
import 'package:library_managment_app/business_logic/books_business_logic.dart';
// import 'package:library_managment_app/data_access/app_database.dart';
// import 'package:library_managment_app/screens/home_page.dart';
//import 'package:library_managment_app/screens/manage_page.dart';
import 'package:library_managment_app/screens/client_page.dart';
import 'package:library_managment_app/screens/employee_page.dart';
// import 'package:library_managment_app/screens/employee_page.dart';

import 'business_logic/connection_status_manager.dart';
import 'data_access/app_database.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  connectionStatus.initialize();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final mealBusinessLogic = BookBusinessLogic(database.bookDao);
  runApp(MainApp(mealBusinessLogic: mealBusinessLogic));
}

class MainApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final BookBusinessLogic mealBusinessLogic;

  MainApp({super.key, required this.mealBusinessLogic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            ClientPage.create(scaffoldMessengerKey, mealBusinessLogic),
        //'/profile': (context) => ProfilePage.create(scaffoldMessengerKey),
        //'/client': (context) =>
            //ManagePage.create(scaffoldMessengerKey, mealBusinessLogic),
        '/employee': (context) =>
            EmployeePage.create(scaffoldMessengerKey, mealBusinessLogic)
      },
    );
  }
}
