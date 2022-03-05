import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class NotificationDbHelper {
  static Future<sql.Database> databse() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'notification.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notification(id TEXT PRIMARY KEY, hour TEXT, minute TEXT, ampm TEXT, active Text)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(Map<String, Object> data) async {
    final db = await databse();
    db.insert(
      'notification',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await databse();
    return db.query('notification');
  }

  static Future<void> delete(String id) async {
    final db = await databse();
    db.delete('notification', where: 'id = $id');
  }
}
