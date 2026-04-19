import 'package:riverpod_learn/Model/post_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._internal();

  static Database? _database;

  DBHelper._internal();

  static Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }

    try {
      String path = '${await getDatabasesPath()}post.db';
      _database = await openDatabase(path, version: 1, onCreate: (db, version) {
        return db.execute('''
        CREATE TABLE postTable (
          localId INTEGER PRIMARY KEY AUTOINCREMENT,
          id INTEGER,
          userId INTEGER NOT NULL,
          title TEXT NOT NULL,
          body TEXT NOT NULL,
          isFav INTEGER NOT NULL
        )
      ''');
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(PostModel userModel) async {
    return await _database!.insert("postTable", userModel.toJson());
  }

  static Future<int> delete(PostModel userModel) async {
    return await _database!.delete("postTable", where: "id = ?", whereArgs: [userModel.id]);
  }

  static Future<int> deleteAll() async {
    return await _database!.delete("postTable");
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return _database!.query("postTable"); // getlist
  }
}
