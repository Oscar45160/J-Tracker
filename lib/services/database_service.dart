import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const _databaseName = 'consumption.db';
  static const _databaseVersion = 1;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final databasePath = path.join(documentsDirectory, _databaseName);
    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE Consumption (
      id INTEGER PRIMARY KEY,
      type TEXT NOT NULL,
      date TEXT NOT NULL,
      weight REAL
    )
  ''');
  }

  Stream<List<Map<String, dynamic>>> watchAllConsumptions() async* {
    final dbClient = await db;
    yield* dbClient.query('Consumption').asStream().map((event) => event.toList());
  }


  Future<List<Map<String, dynamic>>> getConsumptions() async {
    final dbClient = await db;
    return await dbClient.query('Consumption');
  }

  Future<void> addConsumption(Map<String, dynamic> consumption) async {
    final dbClient = await db;
    await dbClient.insert('Consumption', consumption);
  }

  Future<void> updateConsumption(Map<String, dynamic> consumption) async {
    final dbClient = await db;
    await dbClient.update(
      'Consumption',
      consumption,
      where: 'id = ?',
      whereArgs: [consumption['id']],
    );
  }

  Future<void> deleteConsumption(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'Consumption',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
