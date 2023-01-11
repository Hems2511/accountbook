import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase
{
  Future<Database> createdb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'account.db');

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE account (id INTEGER PRIMARY KEY, name TEXT)');
          //1 -harmit
          //2-renil
          //3-milan
          await db.execute(
              'CREATE TABLE accnt_trans (id INTEGER PRIMARY KEY, acid INTEGER, date TEXT, amount INTEGER,type TEXT,reason TEXT)');
        });

    return database;
  }


}