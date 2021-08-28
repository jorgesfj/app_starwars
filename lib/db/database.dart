import 'dart:convert';

import 'package:app_filmes/models/favorites.dart';
import 'package:app_filmes/models/fetch_characters.dart';
import 'package:app_filmes/models/fetch_movies.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static late DatabaseHelper _databaseHelper;
  static late Database _database;

  String faveTable = 'favorites';
  String colId = 'id';
  String colTitle = 'title';
  String colType = 'type';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper = DatabaseHelper._createInstance();
    return _databaseHelper;
  }

  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'fave.db';

    var faveDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return faveDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $faveTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colType Text)');
  }

  Future<int> insertMovie(Movie movie) async {
    Database db = await this.database;
    var resultado = await db.insert(faveTable, movie.toJson());
    return resultado;
  }

  Future<int> insertChatacter(Character character) async {
    Database db = await this.database;
    var resultado = await db.insert(faveTable, character.toJson());
    return resultado;
  }

  Future<int?> getFave(String title) async {
    Database db = await this.database;
    List<Map> maps = await db.query(faveTable,
        columns: [colId, colTitle], where: "$colTitle = ?", whereArgs: [title]);
    if (maps.length > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<List<Favorite>> getFavorites() async {
    Database db = await this.database;
    var resultado = await db.query(faveTable);

    List<Favorite> lista = resultado.isNotEmpty
        ? resultado.map((c) => Favorite.fromJson(c)).toList()
        : [];

    return lista;
  }

  Future<int> deleteMovie(String title) async {
    var db = await this.database;

    int resultado =
        await db.delete(faveTable, where: "$colTitle = ?", whereArgs: [title]);

    return resultado;
  }

  Future<int> deleteCharacter(String title) async {
    var db = await this.database;

    int resultado =
        await db.delete(faveTable, where: "$colTitle = ?", whereArgs: [title]);

    return resultado;
  }

  Future<int?> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $faveTable');

    int? resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
