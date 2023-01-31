
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

  Future<void> createDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'demo.db'),
      onCreate: (db, version) async {
        await db
            .execute('CREATE TABLE  $userTableName(name TEXT,address TEXT)');
        //   return db.execute(
        //   'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, task TEXT, isCompleted INTEGER)',
        //);
      },
      version: 1,
    );
    print("Create Repo");
  }

  Future<void> insert(User todo) async {
    await _database?.insert(userTableName, todo.toMap());
  }

  // Future<void> delete(User user) async{
  // await _database?.delete(user.toString());
  // }

  Future<List<User>> getUser() async {
    print(_database);
    if (_database != null) {
      final List<Map<String, dynamic>> maps =
          await _database!.query(userTableName);
      return List.generate(maps.length, (i) {
        return User(
          maps[i]['name'],
          maps[i]['address'],
        );
      });
    }
    return [];
  }

  Future<void> updateTask(User user) async {
    await _database?.update(userTableName, user.toMap(),
        where: 'name = ?', whereArgs: [user.name]);
  }

  Future<void> remove(User userlist) async {
    await _database?.delete(userTableName,
        where: 'name = ?',
        whereArgs: [userlist.name]).then((value) => print(" in remove"));
  }
}
