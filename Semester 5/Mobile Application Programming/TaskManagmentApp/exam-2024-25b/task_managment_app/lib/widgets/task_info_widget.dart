import 'package:flutter/material.dart';
import 'package:task_managment_app/data_access/models/task.dart';

class TaskInfoWidget extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onDateSelected; // New callback for date selection
  final String taskDate;
  final bool isDeleteEnabled;

  const TaskInfoWidget({
    Key? key,
    required this.taskDate,
    this.onDelete,
    this.onDateSelected,
    this.isDeleteEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onDateSelected, // Trigger date selection callback
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${_formatDate(DateTime.parse(taskDate))}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                  if (isDeleteEnabled)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        onDelete!();
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
