import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class MessageDbHelper {
  static Future<sql.Database> databse() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'message.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE message(id TEXT PRIMARY KEY, mess TEXT, cate TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await databse();
    db.insert(
      'message',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await databse();
    return db.query('message');
  }

  static Future<void> delete(String id) async {
    final db = await databse();
    db.delete('message', where: 'id = ?', whereArgs: [id]);
  }
}
