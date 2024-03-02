import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_managment_app/business_logic/connection_status_manager.dart';
import 'package:event_managment_app/business_logic/events_business_logic.dart';
import 'package:event_managment_app/business_logic/web_socket_manager.dart';
import 'package:event_managment_app/screens/add_event_page.dart';
import 'package:event_managment_app/screens/event_details_screen.dart';
import 'package:event_managment_app/widgets/event_list_widget.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import '../data_access/models/event.dart';

class ParticipantPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final EventBusinessLogic eventBusinessLogic;

  const ParticipantPage(this.scaffoldMessengerKey, this.eventBusinessLogic,
      {super.key});

  factory ParticipantPage.create(GlobalKey<ScaffoldMessengerState> key,
      EventBusinessLogic eventBusinessLogic) {
    return ParticipantPage(key, eventBusinessLogic);
  }

  @override
  _ParticipantPageState createState() => _ParticipantPageState();
}

class _ParticipantPageState extends State<ParticipantPage> {
  // ConnectionStatusManager connectionStatus =
  // ConnectionStatusManager.getInstance();
  StreamSubscription? _connectionChangeStream;
  // WebSocketManager? _webSocketManager;

  bool _loading = true;
  List<Event> detailsByEvent=[];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus =
    ConnectionStatusManager.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  // @override
  // void dispose() {
  //   _webSocketManager?.disconnect();
  //   ConnectionStatusManager.getInstance().dispose();
  //   widget.eventBusinessLogic.updateTasks();
  //   super.dispose();
  // }

  void openSnackbar(String message, int durationInSeconds) {
    widget.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (mounted && !hasNetwork) {
      openSnackbar(
          "This page is unavailable due to absence of internet connection", 1);
      Navigator.pop(context);
    }
  }

  // void addEvent(String name,String team, String details, String status,int participants,
  //     String type) async {
  //   await widget.eventBusinessLogic
  //       .addEvent(name, team, details, status, participants,type)
  //       .then((_) {
  //     setState(() {});
  //     widget.eventBusinessLogic.syncLocalDbWithServer();
  //   }).catchError((e) {
  //     print('Error adding task: $e');
  //     openSnackbar("Error adding task: $e", 2);
  //   });
  //   setState(() {});
  // }

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
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : EventListWidget(events: widget.eventBusinessLogic.events, onEventSelected:(selectedEvent){
        fetchDetailsByEvent(selectedEvent);
        _showEnrollmentConfirmationDialog(context, selectedEvent);
      },),

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
        currentIndex: 1,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar(
                  "This page is unavailable due to the absence of an internet connection",
                  1,
                );
                Navigator.pop(context);}
              break;
            case 2:
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar(
                  "You cannot access this section while offline.",
                  1,
                );
                Navigator.pop(context);
              }else{
                Navigator.popAndPushNamed(context,"/analytics");}
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
    await widget.eventBusinessLogic.getAllEventsInProgress();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }

  void _showEnrollmentConfirmationDialog(
      BuildContext context, Event selectedEvent) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Enrollment'),
          content: const Text('Are you sure you want to enroll in this event?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                ProgressDialog pr = ProgressDialog(context);
                pr.style(message: 'Enrolling...');

                await pr.show();
                await enrollInEvent(selectedEvent);

                await pr.hide().then((_) => Navigator.pop(context));
              },
              child: const Text('Enroll'),
            ),
          ],
        );
      },
    );
  }

  Future<void> enrollInEvent(Event selectedEvent) async {
    try {
      await widget.eventBusinessLogic.enroll(selectedEvent.id.toString());

      openSnackbar('Enrollment successful!', 2);
    } catch (e) {
      print('Error enrolling in the event: $e');
      openSnackbar('Error enrolling in the event: $e', 2);
    }
  }
}