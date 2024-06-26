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

  TaskDao? _taskDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Tasks` (`localId` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `date` INTEGER NOT NULL, `type` TEXT NOT NULL, `duration` REAL NOT NULL, `priority` TEXT NOT NULL, `category` TEXT NOT NULL, `description` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TaskDao get taskDao {
    return _taskDaoInstance ??= _$TaskDao(database, changeListener);
  }
}

class _$TaskDao extends TaskDao {
  _$TaskDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskInsertionAdapter = InsertionAdapter(
            database,
            'Tasks',
            (Task item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'duration': item.duration,
                  'priority': item.priority,
                  'category': item.category,
                  'description': item.description
                }),
        _taskUpdateAdapter = UpdateAdapter(
            database,
            'Tasks',
            ['localId'],
            (Task item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'duration': item.duration,
                  'priority': item.priority,
                  'category': item.category,
                  'description': item.description
                }),
        _taskDeletionAdapter = DeletionAdapter(
            database,
            'Tasks',
            ['localId'],
            (Task item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'type': item.type,
                  'duration': item.duration,
                  'priority': item.priority,
                  'category': item.category,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Task> _taskInsertionAdapter;

  final UpdateAdapter<Task> _taskUpdateAdapter;

  final DeletionAdapter<Task> _taskDeletionAdapter;

  @override
  Future<List<String>> getAllTasksDays() async {
    return _queryAdapter.queryList('SELECT date FROM Tasks',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _queryAdapter.queryList('SELECT * FROM Tasks',
        mapper: (Map<String, Object?> row) => Task(
            id: row['id'] as int?,
            localId: row['localId'] as int?,
            date: _dateTimeConverter.decode(row['date'] as int),
            type: row['type'] as String,
            duration: row['duration'] as double,
            priority: row['priority'] as String,
            category: row['category'] as String,
            description: row['description'] as String));
  }

  @override
  Future<void> clearTasks() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Tasks');
  }

  @override
  Future<int> insertTask(Task task) {
    return _taskInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertTasks(List<Task> task) {
    return _taskInsertionAdapter.insertListAndReturnIds(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(Task task) async {
    await _taskUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTasks(List<Task> tasks) async {
    await _taskUpdateAdapter.updateList(tasks, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTask(Task task) async {
    await _taskDeletionAdapter.delete(task);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
