// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:event_managment_app/common/helpers/date_time_converter.dart';
import 'package:event_managment_app/data_access/dao/event_dao.dart';
import 'package:event_managment_app/data_access/models/event.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Event])
abstract class AppDatabase extends FloorDatabase {
  EventDao get eventDao;
}