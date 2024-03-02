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

  SupplyDao? _supplyDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Supplies` (`localId` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER, `name` TEXT NOT NULL, `supplier` TEXT NOT NULL, `details` TEXT NOT NULL, `status` TEXT NOT NULL, `quantity` INTEGER NOT NULL, `type` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SupplyDao get supplyDao {
    return _supplyDaoInstance ??= _$SupplyDao(database, changeListener);
  }
}

class _$SupplyDao extends SupplyDao {
  _$SupplyDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _supplyInsertionAdapter = InsertionAdapter(
            database,
            'Supplies',
            (Supply item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'supplier': item.supplier,
                  'details': item.details,
                  'status': item.status,
                  'quantity': item.quantity,
                  'type': item.type
                }),
        _supplyUpdateAdapter = UpdateAdapter(
            database,
            'Supplies',
            ['localId'],
            (Supply item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'supplier': item.supplier,
                  'details': item.details,
                  'status': item.status,
                  'quantity': item.quantity,
                  'type': item.type
                }),
        _supplyDeletionAdapter = DeletionAdapter(
            database,
            'Supplies',
            ['localId'],
            (Supply item) => <String, Object?>{
                  'localId': item.localId,
                  'id': item.id,
                  'name': item.name,
                  'supplier': item.supplier,
                  'details': item.details,
                  'status': item.status,
                  'quantity': item.quantity,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Supply> _supplyInsertionAdapter;

  final UpdateAdapter<Supply> _supplyUpdateAdapter;

  final DeletionAdapter<Supply> _supplyDeletionAdapter;

  @override
  Future<List<Supply>> getAllSupplies() async {
    return _queryAdapter.queryList('SELECT * FROM Supplies',
        mapper: (Map<String, Object?> row) => Supply(
            id: row['id'] as int?,
            localId: row['localId'] as int?,
            name: row['name'] as String,
            supplier: row['supplier'] as String,
            details: row['details'] as String,
            status: row['status'] as String,
            quantity: row['quantity'] as int,
            type: row['type'] as String));
  }

  @override
  Future<void> clearSupplies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Supplies');
  }

  @override
  Future<int> insertSupply(Supply supply) {
    return _supplyInsertionAdapter.insertAndReturnId(
        supply, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertSupplies(List<Supply> supply) {
    return _supplyInsertionAdapter.insertListAndReturnIds(
        supply, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSupply(Supply supply) async {
    await _supplyUpdateAdapter.update(supply, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSupplies(List<Supply> supplies) async {
    await _supplyUpdateAdapter.updateList(supplies, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSupply(Supply supply) async {
    await _supplyDeletionAdapter.delete(supply);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
