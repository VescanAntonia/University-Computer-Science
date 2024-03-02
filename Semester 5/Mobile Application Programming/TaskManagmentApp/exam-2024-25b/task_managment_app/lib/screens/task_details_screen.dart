import 'dart:async';

import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:task_managment_app/business_logic/tasks_business_logic.dart';
import 'package:task_managment_app/data_access/models/task.dart'; // Import your Task model

class TaskDetailsScreen extends StatelessWidget {
  final String selectedDate;
  final List<Task> tasks; // You may need to modify this based on your actual data model
  final TaskBusinessLogic taskBusinessLogic;

  TaskDetailsScreen({required this.selectedDate, required this.tasks,required this.taskBusinessLogic});


  void openSnackbar(BuildContext context, String message, int durationInSeconds) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }


  void deleteTask(context,int index) async {
    //var task = tasks.removeAt(index);
    if (tasks.isEmpty) {
      tasks.removeAt(index);
    }

    try {
      await taskBusinessLogic.deleteTask(index);
      taskBusinessLogic.syncLocalDbWithServer();
    } catch (e) {
      print('Error deleting task: $e');
      openSnackbar(context, 'Error deleting task: $e', 2);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                ProgressDialog pr = ProgressDialog(context);
                pr.style(message: 'Loading...');

                await pr.show();
                deleteTask(context,index);

                await pr.hide().then((_) => Navigator.pop(context));
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks on $selectedDate'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];

          //from here -for delete-
          return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                // Trigger the delete operation when the item is dismissed
                _showDeleteConfirmationDialog(context, index);
              },
              background: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          //to here - and changed the return Card to child
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Type: ${task.type}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('Duration: ${task.duration}'),
                  const SizedBox(height: 8.0),
                  Text('Priority: ${task.priority}'),
                  const SizedBox(height: 8.0),
                  Text('Category: ${task.category}'),
                  const SizedBox(height: 8.0),
                  Text('Description: ${task.description}'),
                ],
              ),
            ),
          ),
          );
        },
      ),
    );
  }
}
