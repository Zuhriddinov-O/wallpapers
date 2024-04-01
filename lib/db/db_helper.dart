import "package:sqflite/sql.dart";
import "package:sqflite/sqflite.dart" as sql;
import "package:wallpapers/storage/wallpapers.dart";

class SqlHelper {
  static Future<void> createProduct(sql.Database database) async {
    database.execute("""
    CREATE PRODUCT rules(
         id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
         photographer TEXT NOT NULL,
         src TEXT NOT NULL,  
         liked BOOLEAN NOT NULL,
    )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "rules.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        return createProduct(database);
      },
    );
  }

  static Future<void> saveSign(Photos photos) async {
    final data = await SqlHelper.db();
    await data.insert("rules", photos.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  static Future<List<Photos>> getAllPhoto() async {
    final data = await SqlHelper.db();
    final maps = await data.query('rules', orderBy: 'id desc');
    return maps.map((e) => Photos.fromJson(e)).toList();
  }

  static Future<void> deletePhoto(int? id) async {
    final data = await SqlHelper.db();
    await data.delete("rules", where: "id = ?", whereArgs: ["$id"]);
  }

  static Future<void> updatePhoto(int? id, Photos photos) async {
    final data = await SqlHelper.db();
    await data.update("rules", photos.toJson(), where: "id = ?", whereArgs: ["$id"]);
  }

  static Future<void> clear() async {
    final data = await SqlHelper.db();
    await data.query("DELETE FROM rules");
  }

  static Future<Photos> getById(int? id) async {
    final data = await SqlHelper.db();
    final list = await data.query("rules", where: "id = ?", whereArgs: ["$id"]);
    final photo = list[0];
    return Photos.fromJson(photo);
  }
}
