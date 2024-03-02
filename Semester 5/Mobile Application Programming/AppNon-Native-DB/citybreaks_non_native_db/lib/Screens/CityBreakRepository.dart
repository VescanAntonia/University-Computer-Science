import '../CityBreak.dart';

class CityBreakRepository {
  List<CityBreak> _cityBreaks = CityBreak.init();

  Future<List<CityBreak>> getAllCityBreaks() async {

    return List<CityBreak>.from(_cityBreaks);
  }

  Future<void> addCityBreak(CityBreak cityBreak) async {
    _cityBreaks.add(cityBreak);
  }

  Future<void> updateCityBreak(CityBreak cityBreak) async {
    // Implement updating an existing city break in the data source
    // For example, you might update data in an API or database
    int index = _cityBreaks.indexWhere((element) => element.id == cityBreak.id);
    if (index != -1) {
      _cityBreaks[index] = cityBreak;
    }
  }

  Future<void> deleteCityBreak(int id) async {
    // Implement deleting a city break from the data source
    // For example, you might delete data from an API or database
    _cityBreaks.removeWhere((element) => element.id == id);
  }
}
