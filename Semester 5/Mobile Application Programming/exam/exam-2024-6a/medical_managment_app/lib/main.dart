import 'package:flutter/material.dart';
import 'package:medical_managment_app/business_logic/connection_status_manager.dart';
import 'package:medical_managment_app/business_logic/supplies_business_logic.dart';
import 'package:medical_managment_app/data_access/app_database.dart';
import 'package:medical_managment_app/screens/medical_organizer_page.dart';
import 'package:medical_managment_app/screens/staff_page.dart';
import 'package:medical_managment_app/screens/supplier_page.dart';
//import 'package:medical_managment_app/screens/top_screen.dart';
// import 'package:task_managment_app/screens/profile_page.dart';
//import 'package:medical_managment_app/screens/participant_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  connectionStatus.initialize();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final mealBusinessLogic = SupplyBusinessLogic(database.supplyDao);
  runApp(MainApp(supplyBusinessLogic: mealBusinessLogic));
}

class MainApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final SupplyBusinessLogic supplyBusinessLogic;

  MainApp({super.key, required this.supplyBusinessLogic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            MedicalOragnizerPage.create(scaffoldMessengerKey, supplyBusinessLogic),
        // '/profile': (context) => ProfilePage.create(scaffoldMessengerKey),
        '/staff': (context) =>
            StaffPage.create(scaffoldMessengerKey, supplyBusinessLogic),
        '/supplier': (context) =>
            SupplierPage.create(scaffoldMessengerKey, supplyBusinessLogic)
      },
    );
  }
}
