
import 'package:marvel_heroes/models/personaje_model.dart';
import 'package:marvel_heroes/providers/database_provider.dart';
import 'package:sqflite/sqflite.dart';

class SuperheroBLL{
  static Future<void> insert(Personaje personaje) async {
    final db = await DatabaseProvider.database;
    await db.insert(
      'superheroes',
      personaje.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(Personaje personaje) async {
    final db = await DatabaseProvider.database;
    await db.update(
      'superheroes',
      personaje.toJson(),
      where: 'id = ?',
      whereArgs: [personaje.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.delete("superheroes", where: 'id = ?', whereArgs: [id]);
    return res;
  }

  static Future<Personaje?> selectById(int id) async {
    final db = await DatabaseProvider.database;
    var res = await db.query("superheroes", where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      return Personaje.fromJson(res.first);
    } else {
      return null;
    }
  }

  static Future<List<Personaje>> selectAll() async {
    final db = await DatabaseProvider.database;
    var res = await db.query("superheroes");
    List<Personaje> list = 
      res.isNotEmpty ? res.map((e) => Personaje.fromJson(e)).toList() : [];
    return list;
  }
}