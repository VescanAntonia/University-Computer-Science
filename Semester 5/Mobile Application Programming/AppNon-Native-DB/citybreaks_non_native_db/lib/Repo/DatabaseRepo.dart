import 'dart:ffi';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:citybreaks_non_native_db/Repo/DatabaseConnection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../CityBreak.dart';

class DatabaseRepo {
  //initialize database
  static const _dbName = "citybreaks.db";
  static const _dbVersion = 1;
  static const _table = "cityBreak";

  //singleton pattern-ensure that only one instance is created
  DatabaseRepo._();

  static final DatabaseRepo dbInstance = DatabaseRepo._();

  //check if the database is null and create a new one it it happens
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    //sql statement to create the table
    await db.execute('''CREATE TABLE $_table
        (_id INTEGER PRIMARY KEY AUTOINCREMENT,
        city TEXT NOT NULL,
        country TEXT NOT NULL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        description TEXT NOT NULL,
        accommodation TEXT NOT NULL,
        budget TEXT NOT NULL)''');
  }

  Future<List<CityBreak>> getCityBreaks() async {
    Database db = await dbInstance.database;

    var citybreaks = await db.query(_table);

    List<CityBreak> citybreakList = citybreaks.isNotEmpty
        ? citybreaks.map((s) => CityBreak.fromMap(s)).toList()
        : [];

    return citybreakList;
  }

  Future<int> add(CityBreak citybreak) async {
    Database db = await dbInstance.database;

    return await db.insert(_table, citybreak.toMap());
  }

  Future<int> removeFromList(int id) async {
    Database db = await dbInstance.database;
    return await db.delete(_table, where: '_id = ?', whereArgs: [id]);
  }

  Future<int> update(CityBreak citybreak) async {
    Database db = await dbInstance.database;
    return await db.update(_table, citybreak.toMap(), where: '_id = ?', whereArgs: [citybreak.id]);
  }



}