import 'package:do_project/task_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String databaseName = 'database.db';
  static Database? db;

  static Future<Database> initializeDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return db ??
        await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          await createTables(db);
        });
  }

  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS Tasks (
        Id TEXT NOT NULL,
        Label TEXT NOT NULL,
        Description TEXT NOT NULL,
        DueDate INT
      )      
      """);
  }

  static Future<int> createItem(Task task) async {
    final db = await SqliteService.initializeDb();

    final id = await db.insert('Tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Task>> getItems() async {
    final db = await SqliteService.initializeDb();

    final List<Map<String, Object?>> queryResult = await db.query('Tasks');
    return queryResult.map((e) => Task.fromMap(e)).toList();
  }
}
