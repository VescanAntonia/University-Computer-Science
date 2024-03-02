// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:task_managment_app/common/helpers/date_time_converter.dart';
import 'package:task_managment_app/data_access/dao/task_dao.dart';
import 'package:task_managment_app/data_access/models/task.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}