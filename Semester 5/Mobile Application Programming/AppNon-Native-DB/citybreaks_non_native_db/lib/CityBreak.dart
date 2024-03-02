import 'package:intl/intl.dart';

class CityBreak {
  static int currentId = 0;
  int? id;
  String city;
  String country;
  DateTime startDate;
  DateTime endDate;
  String description;
  String accommodation;
  int budget;


  CityBreak({this.id, required this.city, required this.country, required this.startDate, required this.endDate, required this.description, required this.accommodation, required this.budget});
  // CityBreak(this.city, this.country, this.startDate, this.endDate,
  //     this.description, this.accommodation, this.budget){
  //   id = currentId++;
  // }


  // CityBreak.fromCityBreak(this.id, this.city, this.country, this.startDate, this.endDate,
  //     this.description, this.accommodation, this.budget);

  factory CityBreak.fromMap(Map<String, dynamic> json) => CityBreak(
      id: json['_id'],
      city: json['city'],
      country: json['country'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      description: json['description'],
      accommodation: json['accommodation'],
      budget: int.parse(json['budget'])
  );

  Map<String, dynamic> toMap(){
    return {
      '_id': id,
      'city': city,
      'country':country,
      'startDate': startDate.toIso8601String(),
      'endDate':endDate.toIso8601String(),
      'description': description,
      'accommodation': accommodation,
      'budget': budget
    };
  }

  static List<CityBreak> init() {
    return [
      CityBreak(
        city: "London",
        country: "England",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 10))),
        description: "Really beautiful city.",
        accommodation: "Ibis style",
        budget: 100,
      ),
      CityBreak(
        city: "Napoli",
        country: "Italy",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 13))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 15))),
        description: "Really beautiful city.",
        accommodation: "Palace hotel",
        budget: 200,
      ),
      CityBreak(
        city: "Brasov",
        country: "Romania",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 07, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 07, 10))),
        description: "Really amazing city.",
        accommodation: "Pearl hotel",
        budget: 400,
      ),
      CityBreak(
        city: "Edinburgh",
        country: "Scotland",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 17))),
        description: "The best city.",
        accommodation: "Ibis style",
        budget: 700,
      ),
      CityBreak(
        city: "Rome",
        country: "Italy",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 05, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 05, 10))),
        description: "Really amazing city.",
        accommodation: "Rose hotel",
        budget: 400,
      ),
      CityBreak(
        city: "Madrid",
        country: "Spain",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 10, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 10, 10))),
        description: "Really beautiful city.",
        accommodation: "Ibis style",
        budget: 100,
      ),
      CityBreak(
        city: "Nice",
        country: "France",
        startDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 03))),
        endDate: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 10))),
        description: "Amazing beach.",
        accommodation: "Sunny hotel",
        budget: 560,
      ),
    ];
  }

}