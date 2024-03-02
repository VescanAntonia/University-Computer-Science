// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkoutDao? _workoutDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Workouts` (`localId` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `name` TEXT NOT NULL, `type` TEXT NOT NULL, `duration` REAL NOT NULL, `calories` REAL NOT NULL, `date` INTEGER NOT NULL, `notes` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorkoutDao get workoutDao {
    return _workoutDaoInstance ??= _$WorkoutDao(database, changeListener);
  }
}

class _$WorkoutDao extends WorkoutDao {
  _$WorkoutDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workoutInsertionAdapter = InsertionAdapter(
            database,
            'Workouts',
            (Workout item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'duration': item.duration,
                  'calories': item.calories,
                  'date': _dateTimeConverter.encode(item.date),
                  'notes': item.notes
                }),
        _workoutUpdateAdapter = UpdateAdapter(
            database,
            'Workouts',
            ['localId'],
            (Workout item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'duration': item.duration,
                  'calories': item.calories,
                  'date': _dateTimeConverter.encode(item.date),
                  'notes': item.notes
                }),
        _workoutDeletionAdapter = DeletionAdapter(
            database,
            'Workouts',
            ['localId'],
            (Workout item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'type': item.type,
                  'duration': item.duration,
                  'calories': item.calories,
                  'date': _dateTimeConverter.encode(item.date),
                  'notes': item.notes
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Workout> _workoutInsertionAdapter;

  final UpdateAdapter<Workout> _workoutUpdateAdapter;

  final DeletionAdapter<Workout> _workoutDeletionAdapter;

  @override
  Future<List<Workout>> getAllWorkouts() async {
    return _queryAdapter.queryList('SELECT * FROM Workouts',
        mapper: (Map<String, Object?> row) => Workout(
            id: row['id'] as int?,
            localId: row['localId'] as int?,
            name: row['name'] as String,
            type: row['type'] as String,
            duration: row['duration'] as double,
            calories: row['calories'] as double,
            date: _dateTimeConverter.decode(row['date'] as int),
            notes: row['notes'] as String));
  }

  @override
  Future<void> clearWorkouts() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Workouts');
  }

  @override
  Future<int> insertWorkout(Workout workout) {
    return _workoutInsertionAdapter.insertAndReturnId(
        workout, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertWorkouts(List<Workout> workout) {
    return _workoutInsertionAdapter.insertListAndReturnIds(
        workout, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    await _workoutUpdateAdapter.update(workout, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateWorkouts(List<Workout> workouts) async {
    await _workoutUpdateAdapter.updateList(workouts, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWorkout(Workout workout) async {
    await _workoutDeletionAdapter.delete(workout);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
