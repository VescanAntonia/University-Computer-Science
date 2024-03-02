import 'package:flutter/material.dart';
import 'package:event_managment_app/business_logic/connection_status_manager.dart';
import 'package:event_managment_app/business_logic/events_business_logic.dart';
import 'package:event_managment_app/data_access/app_database.dart';
import 'package:event_managment_app/screens/home_page.dart';
import 'package:event_managment_app/screens/top_screen.dart';
// import 'package:task_managment_app/screens/profile_page.dart';
import 'package:event_managment_app/screens/participant_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  connectionStatus.initialize();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final mealBusinessLogic = EventBusinessLogic(database.eventDao);
  runApp(MainApp(eventBusinessLogic: mealBusinessLogic));
}

class MainApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  final EventBusinessLogic eventBusinessLogic;

  MainApp({super.key, required this.eventBusinessLogic});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            HomePage.create(scaffoldMessengerKey, eventBusinessLogic),
        // '/profile': (context) => ProfilePage.create(scaffoldMessengerKey),
        '/participant': (context) =>
            ParticipantPage.create(scaffoldMessengerKey, eventBusinessLogic),
        '/analytics': (context) =>
            TopPage.create(scaffoldMessengerKey, eventBusinessLogic)
      },
    );
  }
}
