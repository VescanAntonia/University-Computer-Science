import 'package:intl/intl.dart';

class CityBreak {
  static int currentId = 0;
  late int id;
  String city;
  String country;
  DateTime startDate;
  DateTime endDate;
  String description;
  String accommodation;
  int budget;

  CityBreak(this.city, this.country, this.startDate, this.endDate,
      this.description, this.accommodation, this.budget){
    id = currentId++;
  }


  CityBreak.fromCityBreak(this.id, this.city, this.country, this.startDate, this.endDate,
      this.description, this.accommodation, this.budget);

  static List<CityBreak> init() {

    List<CityBreak> cityBreaks = [
      CityBreak("London", "England",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 10))),
          "Really beautiful city.","Ibis style",100),
      CityBreak("Napoli", "Italy",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 13))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 04, 15))),
          "Really beautiful city.","Palace hotel",200),
      CityBreak("Brasov", "Romania",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 07, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 07, 10))),
          "Really amazing city.","Pearl hotel",400),
      CityBreak("Edinburgh", "Scotland",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 17))),
          "The best city.","Ibis style",700),
      CityBreak("Rome", "Italy",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 05, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 05, 10))),
          "Really amazing city.","Rose hotel",400),
      CityBreak("Madrid", "Spain",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 10, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 10, 10))),
          "Really beautiful city.","Ibis style",100),
      CityBreak("Nice", "France",  DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 03))), DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime(2023, 08, 10))),
          "Amazing beach.","Sunny hotel",560),
    ];

    return cityBreaks;
  }
}