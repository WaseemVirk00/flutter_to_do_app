import 'package:flutter_to_do_app/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  static final int? _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + "task.db";

      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating new one");
        return db.execute(
          'CREATE TABLE $_tableName ('
          'id INTEGER PRIMARY KEY,'
          'title STRING, note STRING,date STRING,'
          'startTime STRING,endTime STRING,'
          'remind STRING, repeat STRING,'
          'color INTEGER,'
          'isCompleted INTEGER'
          ')',
        );
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("inser function called");
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate(
        '''update tasks set isCompleted = ? where id = ?''', [1, id]);
  }
}
