import 'dart:async';

import '../models/simple_recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbProvider {
  // inisialisasi nama dan kolom table
  final String tableName = 'resep';
  final String id = 'id';
  final String dishImage = 'dishImage';
  final String title = 'title';
  final String duration = 'duration';
  final String source = 'source';
  final String information = 'information';

  // create private constructor
  DbProvider._();
  static final DbProvider db = DbProvider._();

  // setup database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  // create database
  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    // com.example.fooderlich/database
    final path = join(databasePath, 'fooderlich.db');
    // com.example.fooderlich/database/fooderlich.db

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    final sql = 'CREATE TABLE $tableName($id TEXT PRIMARY KEY, '
        '$dishImage TEXT, $title TEXT, $duration TEXT, $source TEXT, '
        '$information TEXT)';

    await db.execute(sql);
  }

  // insert ke tabel resep
  Future<int> addResep(SimpleRecipe recipe) async {
    final dbClient = await database;
    final res = await dbClient!.insert(tableName, recipe.toMap());
    //print('id Add $dbClient');
    return res;
  }

  // delete resep
  Future<int> delResep(String id) async {
    final dbClient = await database;
    final res = await dbClient!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    //print('id Add $dbClient');
    return res;
  }

  // get resep by ID
  Future<bool> getByID(String id) async {
    final dbClient = await database;
    final recipeList = await dbClient!.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return recipeList.isNotEmpty ? true : false;
  }

  Future<List<SimpleRecipe>> getAllResep() async {
    final dbClient = await database;
    final recipeList = await dbClient!.query(tableName);
    print('Recipe list $recipeList');
    var recipes = <SimpleRecipe>[];
    if (recipeList != null) {
      recipes = parseResep(recipeList);
    }
    return recipes;
  }

  List<SimpleRecipe> parseResep(List<Map<String, dynamic>> recipeList) {
    final recipes = <SimpleRecipe>[];
    for (final recipeMap in recipeList) {
      final recipe = SimpleRecipe.fromJson(recipeMap);
      recipes.add(recipe);
    }
    return recipes;
  }
}
