import 'package:flutter_food_app/features/foods/domain/entity/food_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const tableName = 'foods';

class FoodDatabaseProvider {
  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDatabase();

    return _db!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'foods.db'),
        version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async =>
      await db.execute('''CREATE TABLE $tableName (
            idMeal TEXT PRIMARY KEY,
            strMeal TEXT,
            strCategory TEXT,
            strArea TEXT,
            strInstructions TEXT,
            strMealThumb TEXT,
            strTags TEXT,
            ingredients TEXT,
            measures TEXT
          )''');

  Future<int> createFood(FoodEntity food) async {
    try {
      final json = food.toJson();
      final db = await database;

      json['ingredients'] =
          food.ingredients?.where((item) => item.trim().isNotEmpty).join(",");
      json['measures'] =
          food.measures?.where((item) => item.trim().isNotEmpty).join(",");

      return await db.insert(tableName, json,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print(e);

      return 0;
    }
  }

  Future<List<FoodEntity>> getFoods() async {
    try {
      final db = await database;
      final results = await db.query(tableName);

      if (results.isNotEmpty) {
        return results.map((item) => FoodEntity.fromMap(item)).toList();
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<FoodEntity?> getFood(String id) async {
    final db = await database;
    final results =
        await db.query(tableName, where: 'idMeal = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return FoodEntity.fromMap(results.first);
    }

    return null;
  }

  Future<int> updateFood(FoodEntity food) async {
    final json = food.toJson();
    final db = await database;

    json['ingredients'] = food.ingredients.toString();
    json['measures'] = food.measures.toString();

    return await db
        .update(tableName, json, where: 'idMeal = ?', whereArgs: [food.id]);
  }

  Future<int> deleteFood(String id) async {
    final db = await database;
    return await db.delete(tableName, where: 'idMeal = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    await db.close();
  }
}
