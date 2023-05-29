import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quikke/data/models/stat.dart';
import 'package:sqflite/sqflite.dart';

class StatsDatabase{
  static final StatsDatabase instance = StatsDatabase._init();
  static Database? _database;

  final String _nameDB = 'Stats.db';

  StatsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_nameDB);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory dbPath = await getApplicationDocumentsDirectory();
    String path = "$dbPath/$filePath";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableStats(${StatFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${StatFields.guesses} INTEGER NOT NULL, ${StatFields.failures} INTEGER NOT NULL, ${StatFields.day} TEXT NOT NULL)");
  }

  void close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Stat> create(Stat stat) async {
    final db = await instance.database;
    final id = await db.insert(tableStats, stat.toMap());
    return stat.copy(id: id);
  }
  Future<void> clearAll() async {
    final db = await instance.database;
    await db.delete(tableStats);
  }

  Future<Stat> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableStats,
      columns: StatFields.values,
      where: '${StatFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Stat.fromMap(maps.first);
    }
    else{
      throw Exception('not found $id');
    }
  }
  Future<List<Stat>> readAll() async {
    final db = await instance.database;
    final maps = await db.query(
      tableStats,
      columns: StatFields.values,
    );

    if(maps.isNotEmpty){
      List<Stat> stats = [];
      maps.forEach((map) {
        stats.add(Stat.fromMap(map));
      });
      return stats;
    }
    else{
      throw Exception('not found');
    }
  }
}