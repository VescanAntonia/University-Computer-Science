import 'package:flutter/material.dart';
import 'package:fitnessapp/data_access/models/workout.dart';
import 'package:fitnessapp/widgets/workout_info_widget.dart';

class WorkoutListWidget extends StatelessWidget {
  final List<Workout> workouts;

  const WorkoutListWidget({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        return WorkoutInfoWidget(workout: workouts[index]);
      },
    );
  }
}