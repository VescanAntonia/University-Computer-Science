import 'dart:async';

import 'package:flutter/material.dart';
import 'package:event_managment_app/business_logic/connection_status_manager.dart';
import 'package:event_managment_app/business_logic/events_business_logic.dart';
import 'package:event_managment_app/data_access/models/event.dart';
import 'package:event_managment_app/widgets/event_top_widget.dart';
//import 'package:event_managment_app/widgets/month_duration_widget.dart';

class TopPage extends StatefulWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final EventBusinessLogic eventBusinessLogic;

  const TopPage(this.scaffoldMessengerKey, this.eventBusinessLogic,
      {super.key});

  factory TopPage.create(GlobalKey<ScaffoldMessengerState> key,
      EventBusinessLogic eventBusinessLogic) {
    return TopPage(key, eventBusinessLogic);
  }

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  StreamSubscription? _connectionChangeStream;

  bool _loading = true;
  List<Event> events = [];
  List<Event> tasksInRange = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusManager connectionStatus = ConnectionStatusManager.getInstance();
    _connectionChangeStream = connectionStatus.connectionChange.listen(_connectionChanged);
    fetchData();
  }

  void _connectionChanged(dynamic hasNetwork) {
    if (mounted && !hasNetwork) {
      openSnackbar("This page is unavailable due to the absence of an internet connection", 1);
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
      appBar: AppBar(
        title: const Text('Top 5 events'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              "Top 5 events by participants",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EventTopWidget(event: events[index], nrParticipants: events[index].participants.toString()),
                );
              },
            ),
          ),
        ],
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
            label: 'Top',
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
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar("This page is unavailable due to the absence of an internet connection", 1);
              } else {
                Navigator.popAndPushNamed(context, "/participant");
              }
              break;
            case 2:
              if (!widget.eventBusinessLogic.hasNetwork) {
                openSnackbar("You cannot access this section while offline.", 1);
                Navigator.pop(context);
              }
              break;
          }
        },
      ),
    );
  }

  fetchData() async {
    events = await widget.eventBusinessLogic.getTopFiveEventsByParticipantsAndStatus();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _loading = false;
    });
  }
}
