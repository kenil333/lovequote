import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class PicDbHelper {
  static Future<sql.Database> databse() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pic.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE pic(id TEXT PRIMARY KEY, mess TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await databse();
    db.insert(
      'pic',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await databse();
    return db.query('pic');
  }

  static Future<void> delete(String id) async {
    final db = await databse();
    db.delete('pic', where: 'id = ?', whereArgs: [id]);
  }
}
