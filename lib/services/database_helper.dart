import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/menu_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  
  // Singleton pattern
  factory DatabaseHelper() => _instance;
  
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'menu_creator.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE menu_items(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, price REAL, category TEXT)',
    );
  }

  // Insert a menu item
  Future<int> insertMenuItem(MenuItem item) async {
    Database db = await database;
    return await db.insert('menu_items', item.toMap());
  }

  // Get all menu items
  Future<List<MenuItem>> getMenuItems() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('menu_items');
    
    return List.generate(maps.length, (i) {
      return MenuItem.fromMap(maps[i]);
    });
  }

  // Get menu items by category
  Future<List<MenuItem>> getMenuItemsByCategory(String category) async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'menu_items',
      where: 'category = ?',
      whereArgs: [category],
    );
    
    return List.generate(maps.length, (i) {
      return MenuItem.fromMap(maps[i]);
    });
  }

  // Update a menu item
  Future<int> updateMenuItem(MenuItem item) async {
    Database db = await database;
    return await db.update(
      'menu_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Delete a menu item
  Future<int> deleteMenuItem(int id) async {
    Database db = await database;
    return await db.delete(
      'menu_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}