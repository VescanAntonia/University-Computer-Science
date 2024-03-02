import 'package:floor/floor.dart';

@Entity(tableName: 'Events')
class Event {
  @PrimaryKey(autoGenerate: true)
  int? localId;
  int? id;
  final String name;
  final String team;
  final String details;
  final String status;
  final int participants;
  final String type;

  Event(
      {this.id,
        this.localId,
        required this.name,
        required this.team,
        required this.details,
        required this.status,
        required this.participants,
        required this.type});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name:json["name"]?? "",
    team: json["team"] ?? "",
    details: json["details"]?? "",
    status: json["status"]?? "",
    participants: int.parse(json["participants"].toString()),
    type: json["type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "team": team,
    "details": details,
    "status": status,
    "participants": participants,
    "type":type
  };
}