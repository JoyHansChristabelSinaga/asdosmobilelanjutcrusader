import '../models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:synchronized/synchronized.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;
  static const _dbVersion = 1;

  DBHelper._internal();
  factory DBHelper() => _instance;

  // inisialisasi nama dan kolom pada tabel di database
  final String tableName = 'resep';
  final String id = 'id';
  final String dishImage = 'dishImage';
  final String title = 'title';
  final String duration = 'duration';
  final String source = 'source';
  final String information = 'information';

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();

    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "fooderlich_test.db");

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // Membuat table dan kolom nya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName ($id TEXT PRIMARY KEY, "
        "$dishImage TEXT, "
        "$title TEXT, "
        "$duration TEXT, "
        "$source TEXT, "
        "$information TEXT)";

    await db.execute(sql);
  }

  // insert data recipe yang di favoritkan
  Future<int?> addResep(SimpleRecipe recipe) async {
    var dbClient = await _db;

    return await dbClient!.insert(tableName, recipe.toMap());
  }

  // Ambil data recipe yang di favorite kan
  Future<List?> getAllRecipes() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      id,
      dishImage,
      title,
      duration,
      source,
      information,
    ]);
    return result.toList();
  }

  // delete recipe favorite
  Future<int?> deleteRecipe(String id) async {
    var dbClient = await _db;
    return await dbClient!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<SimpleRecipe?> getRecipe(String _id) async {
    final dbClient = await _db;
    List<Map<String, dynamic>> maps = await dbClient!.query(tableName,
        columns: [this.id, dishImage, title, duration, source, information],
        where: 'id = ?',
        whereArgs: [_id]);
    if (maps.isNotEmpty) {
      return SimpleRecipe.fromMap(maps.first);
    }
    return null;
  }
}
