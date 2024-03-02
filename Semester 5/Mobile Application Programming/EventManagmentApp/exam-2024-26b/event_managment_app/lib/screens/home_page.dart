import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_managment_app/business_logic/connection_status_manager.dart';
import 'package:event_managment_app/business_logic/events_business_logic.dart';
import 'package:event_managment_app/business_logic/web_socket_manager.dart';
import 'package:event_managment_app/screens/add_event_page.dart';
import 'package:event_managment_app/screens/event_details_screen.dart';
import 'package:event_managment_app/widgets/event_list_widget.dart';
import '../data_access/models/event.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final EventBusinessLogic eventBusinessLogic;

  const HomePage(this.scaffoldMessengerKey, this.eventBusinessLogic,
      {super.key});

  factory HomePage.create(GlobalKey<ScaffoldMessengerState> key,
      EventBusinessLogic eventBusinessLogic) {
    return HomePage(key, eventBusinessLogic);
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectionStatusManager connectionStatus =
  ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Event> detailsByEvent=[];

  @override
  void initState() {
    super.initState();

    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    connectionStatus.hasNetwork();
  }

  @override
  void dispose() {
    _webSocketManager?.disconnect();
    ConnectionStatusManager.getInstance().dispose();
    widget.eventBusinessLogic.updateTasks();
    super.dispose();
  }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (!widget.eventBusinessLogic.hasNetwork && hasNetwork) {
      openSnackbar(
          "You are connected to internet. Your application has been updated with the server.",
          2);
      _webSocketManager = WebSocketManager(onMessageReceived: (remoteMeal) {
        var event = widget.eventBusinessLogic.addRemoteTask(remoteMeal);
        var message =
            "A new event was added. Name: ${event.name}, status: ${event.status}, type: ${event.type}";
        openSnackbar('Notification: $message', 2);
      });
      widget.eventBusinessLogic.hasNetwork = true;
    } else if (!hasNetwork) {
      openSnackbar(
          "There is no connection to internet! Loaded from local database.", 2);
      _webSocketManager?.disconnect();
      _webSocketManager = null;
      widget.eventBusinessLogic.hasNetwork = false;
      widget.eventBusinessLogic.saveTasks();
    }
    fetchData();
  }

  void addEvent(String name,String team, String details, String status,int participants,
      String type) async {
    await widget.eventBusinessLogic
        .addEvent(name, team, details, status, participants,type)
        .then((_) {
      setState(() {});
      widget.eventBusinessLogic.syncLocalDbWithServer();
    }).catchError((e) {
      print('Error adding task: $e');
      openSnackbar("Error adding task: $e", 2);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.person),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/profile');
        //     },
        //   ),
        // ],
      ),
      body: _loading || widget.eventBusinessLogic.events.isEmpty
          ? Center(
          child: Column(children: [
            const CircularProgressIndicator(),
            const Text("Waiting for internet connection"),
            ElevatedButton(
                onPressed: () => connectionStatus.hasNetwork(),
                child: const Text("Retry connection"))
          ]))
          : EventListWidget(events: widget.eventBusinessLogic.events,onEventSelected:(selectedEvent){
        fetchDetailsByEvent(selectedEvent);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>EventDetailsScreen(selectedEvent:selectedEvent.name,details:detailsByEvent,eventBusinessLogic: widget.eventBusinessLogic),),);
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEventPage(onSave: addEvent)),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.drag_handle),
            label: 'Participant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_exploration),
            label: 'Analytics',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 1:
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Future pushNamed = Navigator.pushNamed(context, '/participant');
                pushNamed.then((_) => setState(() {}));
              }
              break;
            case 2:
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar(
                    "You cannot access this section while offline.", 1);
              } else {
                Navigator.pushNamed(context, '/analytics');
              }
              break;

          }
        },
      ),
    );
  }
  void fetchDetailsByEvent(Event selectedEvent) async {
    List<Event> events = await widget.eventBusinessLogic.getDetailsByEvent(selectedEvent.id.toString());
    setState(() {
      detailsByEvent = events;
    });
  }

  fetchData() async {
    await widget.eventBusinessLogic.syncLocalDbWithServer();
    await widget.eventBusinessLogic.getAllEvents();
    setState(() {
      _loading = false;
    });
  }
}