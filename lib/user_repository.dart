import 'package:arraycrud_sqflite/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserRepository {
  // UserRepository userRepository = new  UserRepository();
  static Database? _database;
  final userTableName = "USER";
  UserRepository() {
    print(" user repository");
    createDatabase();
    print(" in constructor");
  }
  // void createDatabase() async {
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, 'demo.db');
  //   Future<Database?> Opendb({
  //     path,
  //     version: 1,
  //   }) async {
  //     print(" in database created before open db");
  //     db = await openDatabase((await getDatabasesPath()));
  //     print(" in database created after open db");
  //     onCreate:
  //     (Database db, int version) async {
  //       print(" in database created in create method");

  //       await db.execute(
  //           'CREATE TABLE IF NOT EXISTS $userTableName(name TEXT,address TEXT');
  //       print(" in database created");
  //     };
  //   }
  // }
  Future<void> createDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'demo.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE  $userTableName(name TEXT,address TEXT)');
        //   return db.execute(
        //   'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, task TEXT, isCompleted INTEGER)',
        //);
      },
      version: 1,
    );
  }

  Future<void> insert(User todo) async {
    await _database?.insert(userTableName, todo.toMap());
  }

  Future<List<User>> getUser() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps =
          await _database!.query(userTableName);
      return [];//_database!.query(userTableName);
      print(maps);
    }
    return [];
  }
}





// await database.transaction((txn) async {
//   int id1 = await txn.rawInsert(
//       'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
//   print('inserted1: $id1');
//   int id2 = await txn.rawInsert(
//       'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
//       ['another name', 12345678, 3.1416]);
//   print('inserted2: $id2');
// });