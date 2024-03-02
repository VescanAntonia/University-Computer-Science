import 'package:floor/floor.dart';

@Entity(tableName: 'Workouts')
class Workout {
  @PrimaryKey(autoGenerate: true)
  int? localId;
  int? id;
  final String name;
  final String type;
  final double duration;
  final double calories;
  final DateTime date;
  final String notes;

  Workout(
      {this.id,
        this.localId,
        required this.name,
        required this.type,
        required this.duration,
        required this.calories,
        required this.date,
        required this.notes});

  factory Workout.fromJson(Map<String, dynamic> json) => Workout(
    id: json["id"],
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    duration: json["duration"] +0.0,
    calories: json["calories"] + 0.0,
    date: DateTime.parse(json["date"].toString()),
    notes: json["notes"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "duration" :duration,
    "calories": calories,
    "date": date.toIso8601String(),
    "notes": notes
  };
}