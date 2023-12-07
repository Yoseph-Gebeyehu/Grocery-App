import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class SQLDatabaseService {
  static String dataBaseName = "grocery.db";
  static String databasePath = "";

  static String user = "user";

  static getDatabasePath() async {
    var dbPath = await sql.getDatabasesPath();
    databasePath = path.join(dbPath, dataBaseName);
    return databasePath;
  }

  static Future<sql.Database> openDatabase() async {
    final dbpath = await getDatabasePath();
    return await sql.openDatabase(
      dbpath,
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await db.execute('''
CREATE TABLE $user (id INTEGER PRIMARY KEY AUTOINCREMENT,userName TEXT,email TEXT,password TEXT)''');
      },
    );
  }

  static deleteDatabase() async {
    String dbPath = await getDatabasePath();
    await sql.deleteDatabase(dbPath);
  }
}
