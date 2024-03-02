import 'package:floor/floor.dart';

@Entity(tableName: 'Supplies')
class Supply {
  @PrimaryKey(autoGenerate: true)
  int? localId;
  int? id;
  final String name;
  final String supplier;
  final String details;
  final String status;
  final int quantity;
  final String type;

  Supply(
      {this.id,
        this.localId,
        required this.name,
        required this.supplier,
        required this.details,
        required this.status,
        required this.quantity,
        required this.type});

  factory Supply.fromJson(Map<String, dynamic> json) => Supply(
    id: json["id"],
    name: json["name"] ?? "",
    supplier: json["supplier"] ?? "",
    details: json["details"] ?? "",
    status: json["status"]?? "",
    quantity: int.parse(json["quantity"].toString()),
    type: json["type"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "supplier": supplier,
    "details": details,
    "status": status,
    "quantity": quantity,
    "type":type
  };
}