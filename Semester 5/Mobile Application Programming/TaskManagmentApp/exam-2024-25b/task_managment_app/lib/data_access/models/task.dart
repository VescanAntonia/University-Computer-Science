import 'package:floor/floor.dart';

@Entity(tableName: 'Tasks')
class Task {
  @PrimaryKey(autoGenerate: true)
  int? localId;
  int? id;
  final DateTime date;
  final String type;
  final double duration;
  final String priority;
  final String category;
  final String description;

  Task(
      {this.id,
        this.localId,
        required this.date,
        required this.type,
        required this.duration,
        required this.priority,
        required this.category,
        required this.description});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    date:DateTime.parse(json["date"].toString()),
    type: json["type"] ?? "",
    duration: json["duration"] + 0.0,
    priority: json["priority"]?? "",
    category: json["category"]?? "",
    description: json["description"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "type": type,
    "duration": duration,
    "priority": priority,
    "category": category,
    "description":description
  };
}