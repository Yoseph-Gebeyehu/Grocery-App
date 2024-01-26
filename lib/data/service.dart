import 'package:grocery/data/models/user.dart';
import 'package:sqflite/sqflite.dart';

import 'local/sqflite.dart';

class UserServies {
  Future<void> addUserToDB(User user) async {
    Map<String, dynamic> data = user.toJson();

    Database db = await SQLDatabaseService.openDatabase();

    await db.insert(
      SQLDatabaseService.user,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<User>> getUserFromDB() async {
    List<User> user = [];
    Database db = await SQLDatabaseService.openDatabase();
    var result = await db.query(SQLDatabaseService.user);

    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        user.add(User.fromJson(result[i]));
      }
    }
    return user;
  }

  static Future<void> updateUserInDB(User user) async {
    Map<String, dynamic> data = user.toJson();

    Database db = await SQLDatabaseService.openDatabase();

    await db.update(
      SQLDatabaseService.user,
      data,
      where: 'userName = ?',
      whereArgs: [user.userName],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // print(data);
  }
}
