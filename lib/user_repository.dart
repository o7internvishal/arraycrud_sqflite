import 'package:arraycrud_sqflite/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  Database? db;
  final userTableName = "USER";
  
  void createTable() {
    db?.execute('CREATE TABLE $userTableName(name TEXT,address TEXT');
  }

Future<void> insert(User todo) async {
    await db?.insert(userTableName, todo.toMap());
  }


  getUser() async {
    final List<Map<String, dynamic>> maps = await db!.query(userTableName);

    print(maps);
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