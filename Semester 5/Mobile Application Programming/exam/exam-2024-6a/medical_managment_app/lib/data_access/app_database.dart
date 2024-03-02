// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:medical_managment_app/common/helpers/date_time_converter.dart';
import 'package:medical_managment_app/data_access/dao/supply_dao.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Supply])
abstract class AppDatabase extends FloorDatabase {
  SupplyDao get supplyDao;
}