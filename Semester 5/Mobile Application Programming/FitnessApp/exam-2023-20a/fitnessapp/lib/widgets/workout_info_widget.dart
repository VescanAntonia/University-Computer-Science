import 'package:flutter/material.dart';
import 'package:fitnessapp/data_access/models/workout.dart';

class WorkoutInfoWidget extends StatelessWidget {
  final VoidCallback? onDelete;
  final Workout workout;
  final bool isDeleteEnabled;

  const WorkoutInfoWidget(
      {Key? key,
        required this.workout,
        this.onDelete,
        this.isDeleteEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${workout.name}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Type: ${workout.type}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Duration: ${workout.duration} min',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Calories: ${workout.calories} kcal',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Consumption Date: ${_formatDate(workout.date)}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                        width: 300,
                        child: Text(
                          'Notes: ${workout.notes}',
                          style:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                        )),
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
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}