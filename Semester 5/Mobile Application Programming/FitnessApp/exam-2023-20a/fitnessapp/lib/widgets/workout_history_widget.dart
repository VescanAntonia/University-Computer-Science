import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/data_access/models/workout.dart';
import 'package:fitnessapp/widgets/workout_info_widget.dart';

class WorkoutHistoryWidget extends StatefulWidget {
  final List<Workout> workouts;
  const WorkoutHistoryWidget({super.key, required this.workouts});

  @override
  _WorkoutHistoryWidgetState createState() => _WorkoutHistoryWidgetState();
}

class _WorkoutHistoryWidgetState extends State<WorkoutHistoryWidget> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.workouts.map((e) => e.date).toList().min;
    _endDate = widget.workouts.map((e) => e.date).toList().max;
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedStartDate = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedStartDate != null && pickedStartDate != _startDate) {
      setState(() {
        _startDate = pickedStartDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedEndDate = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedEndDate != null && pickedEndDate != _endDate) {
      setState(() {
        _endDate = pickedEndDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Workout> mealsInRange = widget.workouts.where((meal) {
      return meal.date.isAfter(_startDate.subtract(const Duration(days: 1))) &&
          meal.date.isBefore(_endDate.add(const Duration(days: 1)));
    }).toList();

    return Column(
      children: [
        Text(
          "Workouts between ${_formatDate(_startDate)} and ${_formatDate(_endDate)}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8.0),
            itemCount: mealsInRange.length,
            itemBuilder: (context, index) {
              return WorkoutInfoWidget(workout: mealsInRange[index]);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _selectStartDate(context),
              child: const Text('Select Start Date'),
            ),
            ElevatedButton(
              onPressed: () => _selectEndDate(context),
              child: const Text('Select End Date'),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}