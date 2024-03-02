import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:event_managment_app/business_logic/events_business_logic.dart';
import 'package:event_managment_app/data_access/models/event.dart'; // Import your Task model

class EventDetailsScreen extends StatelessWidget {
  final String selectedEvent;
  final List<Event> details; // You may need to modify this based on your actual data model
  final EventBusinessLogic eventBusinessLogic;

  EventDetailsScreen({required this.selectedEvent, required this.details,required this.eventBusinessLogic});


  void openSnackbar(BuildContext context, String message, int durationInSeconds) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }


  // void deleteEvent(context,int index) async {
  //   //var task = tasks.removeAt(index);
  //   if (details.isEmpty) {
  //     details.removeAt(index);
  //   }
  //
  //   try {
  //     await eventBusinessLogic.deleteEvent(index);
  //     eventBusinessLogic.syncLocalDbWithServer();
  //   } catch (e) {
  //     print('Error deleting task: $e');
  //     openSnackbar(context, 'Error deleting task: $e', 2);
  //   }
  // }

  // void _showDeleteConfirmationDialog(BuildContext context, int index) async {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm Delete'),
  //         content: const Text('Are you sure you want to delete this task?'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               ProgressDialog pr = ProgressDialog(context);
  //               pr.style(message: 'Loading...');
  //
  //               await pr.show();
  //               deleteEvent(context,index);
  //
  //               await pr.hide().then((_) => Navigator.pop(context));
  //             },
  //             child: const Text('Delete', style: TextStyle(color: Colors.red)),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedEvent),
      ),
      body: ListView.builder(
        itemCount: details.length,
        itemBuilder: (context, index) {
          Event event = details[index];

          //from here -for delete-
          // return Dismissible(
          //   key: UniqueKey(),
          //   onDismissed: (direction) {
          //     // Trigger the delete operation when the item is dismissed
          //     _showDeleteConfirmationDialog(context, index);
          //   },
          //   background: Container(
          //     color: Colors.red,
          //     child: Align(
          //       alignment: Alignment.centerRight,
          //       child: Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: Icon(
          //           Icons.delete,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //   ),
            //to here - and changed the return Card to child
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'name: ${event.name}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text('Team: ${event.team}'),
                    const SizedBox(height: 8.0),
                    Text('Details: ${event.details}'),
                    const SizedBox(height: 8.0),
                    Text('Status: ${event.status}'),
                    const SizedBox(height: 8.0),
                    Text('Participants: ${event.participants}'),
                    const SizedBox(height: 8.0),
                    Text('Type: ${event.type}'),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
