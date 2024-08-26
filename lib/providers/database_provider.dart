import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._();
  static Database? _database;
  static final DatabaseProvider db = DatabaseProvider._();

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static initDB() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "dbsuperhero.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE superheroes ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "hero_name TEXT,"
          "description TEXT,"
          "age INTEGER,"
          "height DOUBLE,"
          "weight DOUBLE,"
          "planet TEXT,"
          "strength INTEGER,"
          "intelligence INTEGER,"
          "agility INTEGER,"
          "resistance INTEGER,"
          "speed INTEGER,"
          "image TEXT,"
          "category TEXT,"
          "movieList TEXT"
          ")");
    });
  }

  static Future<void> deleteDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "dbsuperhero.db");
    await databaseFactory.deleteDatabase(path);
  }
}
