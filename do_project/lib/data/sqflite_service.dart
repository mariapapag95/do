import 'package:do_project/data/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String databaseName = 'database.db';
  static Database? _db;

  static Future<Database> openSQLDatabase() async {
    if (_db != null) {
      return _db!;
    }

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _db!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await createTables(db);
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS Tasks (
      id INTEGER PRIMARY KEY,
      label TEXT NOT NULL,
      details TEXT,
      date DATE DEFAULT NULL,
      time DATE DEFAULT NULL,
      createdOn DATE NOT NULL
    )""");
  }

  static Future<int> createItem(Task task) async {
    final db = await openSQLDatabase();

    final id = await db.insert('Tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Task>> getItems() async {
    final db = await openSQLDatabase();

    final List<Map<String, Object?>> queryResult = await db.query('Tasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }
}
