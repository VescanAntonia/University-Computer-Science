import 'package:floor/floor.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';

@dao
abstract class SupplyDao {

  @Query('SELECT * FROM Supplies')
  Future<List<Supply>> getAllSupplies();


  @insert
  Future<int> insertSupply(Supply supply);


  @insert
  Future<List<int>> insertSupplies(List<Supply> supply);


  @delete
  Future<void> deleteSupply(Supply supply);

  @Query('DELETE FROM Supplies')
  Future<void> clearSupplies();

  @update
  Future<void> updateSupply(Supply supply);
  @update
  Future<void> updateSupplies(List<Supply> supplies);
}