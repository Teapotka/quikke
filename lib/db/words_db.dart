import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quikke/data/models/word.dart';
import 'package:sqflite/sqflite.dart';
import 'model_db.dart';

class WordsDatabase extends ModelDatabase<Word> {
  //INIT
  static final WordsDatabase instance = WordsDatabase._init();
  static Database? _database;

  final String _nameDB = 'Words.db';

  WordsDatabase._init();

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
        "CREATE TABLE $tableWords(${WordFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${WordFields.word} TEXT NOT NULL, ${WordFields.meaning} TEXT NOT NULL, ${WordFields.tag} TEXT NOT NULL, ${WordFields.created} TEXT NOT NULL, ${WordFields.status} TEXT NOT NULL)");
  }

  //CRUD
  @override
  void close() async {
    final db = await instance.database;
    db.close();
  }

  @override
  Future<Word> create(Word word) async {
    final db = await instance.database;
    final id = await db.insert(tableWords, word.toMap());
    return word.copy(id: id);
  }

  @override
  Future<void> clearAll() async {
    final db = await instance.database;
    await db.delete(tableWords);
  }

  @override
  Future<Word> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Word.fromMap(maps.first);
    } else {
      throw Exception('not found $id');
    }
  }

  @override
  Future<List<Word>> readAll() async {
    final db = await instance.database;
    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
    );
    if (maps.isNotEmpty) {
      List<Word> words = [];
      maps.forEach((map) {
        words.add(Word.fromMap(map));
      });
      return words;
    } else {
      throw Exception('not found');
    }
  }

  Future<void> edit(Word word) async {
    final db = await instance.database;
    // final value = await read(word.id!);
    print(word.toMap());
    // print(value);
    db.update(
      tableWords,
      word.toMap(),
      where: '${WordFields.id} = ?',
      whereArgs: [word.id!],
    );
  }
  Future<void> resetAllStatuses() async {
    final db = await instance.database;
    final words = await readAll();
    // print(word.toMap());
    // print(value);
    for(var i = 0; i < words.length; i++){
      db.update(
        tableWords,
        words[i].copy(
          status: Status.pure
        ).toMap(),
        where: '${WordFields.id} = ?',
        whereArgs: [words[i].id!],
      );
    }
  }
}
