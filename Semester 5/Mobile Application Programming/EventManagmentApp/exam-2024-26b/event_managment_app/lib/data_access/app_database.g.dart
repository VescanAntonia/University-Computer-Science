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

  EventDao? _eventDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Events` (`localId` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `name` TEXT NOT NULL, `team` TEXT NOT NULL, `details` TEXT NOT NULL, `status` TEXT NOT NULL, `participants` INTEGER NOT NULL, `type` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  EventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }
}

class _$EventDao extends EventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Events',
            (Event item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'team': item.team,
                  'details': item.details,
                  'status': item.status,
                  'participants': item.participants,
                  'type': item.type
                }),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'Events',
            ['localId'],
            (Event item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'team': item.team,
                  'details': item.details,
                  'status': item.status,
                  'participants': item.participants,
                  'type': item.type
                }),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'Events',
            ['localId'],
            (Event item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'team': item.team,
                  'details': item.details,
                  'status': item.status,
                  'participants': item.participants,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Future<List<Event>> getAllEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Events',
        mapper: (Map<String, Object?> row) => Event(
            id: row['id'] as int?,
            localId: row['localId'] as int?,
            name: row['name'] as String,
            team: row['team'] as String,
            details: row['details'] as String,
            status: row['status'] as String,
            participants: row['participants'] as int,
            type: row['type'] as String));
  }

  @override
  Future<void> clearEvents() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Events');
  }

  @override
  Future<int> insertEvent(Event task) {
    return _eventInsertionAdapter.insertAndReturnId(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertEvents(List<Event> task) {
    return _eventInsertionAdapter.insertListAndReturnIds(
        task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvent(Event task) async {
    await _eventUpdateAdapter.update(task, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvents(List<Event> tasks) async {
    await _eventUpdateAdapter.updateList(tasks, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEvent(Event task) async {
    await _eventDeletionAdapter.delete(task);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
