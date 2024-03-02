import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseConnection {
  //creation and setup of a SQLite database

  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_citybreaks'); //create path
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase); //open database

    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        "CREATE TABLE cityBreak"
            "(id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "city TEXT NOT NULL, "
            "country TEXT NOT NULL, "
            "startDate TEXT NOT NULL,"
            "endDate TEXT NOT NULL, "
            "description TEXT NOT NULL, "
            "accommodation TEXT NOT NULL, "
            "budget TEXT NOT NULL)"
    );
  }

}