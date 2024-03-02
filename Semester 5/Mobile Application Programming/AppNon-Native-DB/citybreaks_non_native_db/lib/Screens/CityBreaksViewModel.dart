import 'package:citybreaks_non_native_db/CityBreak.dart';
import 'package:flutter/material.dart';
import '../Repo/DatabaseRepo.dart';

class CityBreaksViewModel extends ChangeNotifier {
  DatabaseRepo databaseRepo=DatabaseRepo.dbInstance;
  late Future<List<CityBreak>> cityBreaks;
  CityBreaksViewModel._();

  static final CityBreaksViewModel viewModel = CityBreaksViewModel._();

  void initState() {
    cityBreaks = databaseRepo.getCityBreaks();
  }

  Future<List<CityBreak>> getAllCityBreaks() async {
    return databaseRepo.getCityBreaks();
  }

  Future<void> addCityBreak(CityBreak cityBreak) async {
    await databaseRepo.add(cityBreak);
    //notifyListeners();
  }

  Future<void> updateCityBreak(CityBreak cityBreak) async {
    await databaseRepo.update(cityBreak);
    //notifyListeners();
    // _cityBreaks = await _repository.getAllCityBreaks(); // Refresh the list
    // notifyListeners();
  }

  Future<void> deleteCityBreak(int id) async {
    await databaseRepo.removeFromList(id);
    //notifyListeners();
    // _cityBreaks = await _repository.getAllCityBreaks(); // Refresh the list
    // notifyListeners();
  }
}
