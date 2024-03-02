import 'package:flutter/material.dart';
import 'package:task_managment_app/data_access/models/task.dart';
import 'package:task_managment_app/widgets/task_info_widget.dart';

class TaskListWidget extends StatelessWidget {
  final List<String> taskDates;
  final Function(String) onDateSelected; // New callback for date selection

  const TaskListWidget({
    Key? key,
    required this.taskDates,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskDates.length,
      itemBuilder: (context, index) {
        return TaskInfoWidget(
          taskDate: taskDates[index],
          onDateSelected: () => onDateSelected(taskDates[index]), // Pass the selected date to the callback
        );
      },
    );
  }
}
