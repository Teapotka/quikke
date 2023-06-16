import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quikke/data/models/stat.dart';
import 'package:quikke/db/model_db.dart';
import 'package:quikke/services/preferences_service.dart';
import 'package:sqflite/sqflite.dart';

class StatsDatabase extends ModelDatabase<Stat> {
  static final StatsDatabase instance = StatsDatabase._init();
  static Database? _database;

  final String _nameDB = 'Stats.db';

  StatsDatabase._init();

  @override
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
        "CREATE TABLE $tableStats(${StatFields
            .id} INTEGER PRIMARY KEY AUTOINCREMENT, ${StatFields
            .result} TEXT NOT NULL, ${StatFields.time} TEXT NOT NULL)");
  }

  @override
  void close() async {
    final db = await instance.database;
    db.close();
  }

  @override
  Future<Stat> create(Stat stat) async {
    final db = await instance.database;
    final id = await db.insert(tableStats, stat.toMap());
    return stat.copy(id: id);
  }

  Future<List<Stat>> createStatsForDay(DateTime day) async {
    final db = await instance.database;
    await PreferencesService.init();
    final range = PreferencesService.getRange();
    final start = range["start"]!;
    final end = range["end"]!;
    final intervals = [for (var i = start; i <= end; i++) i];
    final timeIntervals = intervals.map((interval) =>
        day.copyWith(hour: interval, minute: 0));
    final statList = timeIntervals.map((interval) => Stat(
        result: Result.waiting,
        time: interval
    )).toList();

    await Future.wait(statList.map((stat) async {
      await db.insert(tableStats, stat.toMap());
      print(stat.toMap());
    }));
    // await db.insert(tableStats, stat.toMap());
    print(statList);

    return statList;
    // final id = await db.insert(tableStats, stat.toMap());
    // return stat.copy(id: id);
  }

  @override
  Future<void> clearAll() async {
    final db = await instance.database;
    await db.delete(tableStats);
  }

  @override
  Future<Stat> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableStats,
      columns: StatFields.values,
      where: '${StatFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Stat.fromMap(maps.first);
    }
    else {
      throw Exception('not found $id');
    }
  }

  @override
  Future<List<Stat>> readAll() async {
    final db = await instance.database;
    final maps = await db.query(
      tableStats,
      columns: StatFields.values,
    );

    if (maps.isNotEmpty) {
      List<Stat> stats = [];
      maps.forEach((map) {
        stats.add(Stat.fromMap(map));
      });
      return stats;
    }
    else {
      // throw Exception('not found');
      return [];
    }
  }
  Future<void> edit(Stat stat) async {
    final db = await instance.database;
    // final value = await read(word.id!);
    print(stat.toMap());
    // print(value);
    db.update(
      tableStats,
      stat.toMap(),
      where: '${StatFields.id} = ?',
      whereArgs: [stat.id!],
    );
  }
}
