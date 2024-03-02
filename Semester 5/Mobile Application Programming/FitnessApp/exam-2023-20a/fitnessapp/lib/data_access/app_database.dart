// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:fitnessapp/common/helpers/date_time_converter.dart';
import 'package:fitnessapp/data_access/dao/workout_dao.dart';
import 'package:fitnessapp/data_access/models/workout.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Workout])
abstract class AppDatabase extends FloorDatabase {
  WorkoutDao get workoutDao;
}