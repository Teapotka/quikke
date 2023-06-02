import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:quikke/data/models/word.dart';
import 'package:sqflite/sqflite.dart';

class WordsDatabase {
  //INIT
  static final WordsDatabase instance = WordsDatabase._init();
  static Database? _database;

  final String _nameDB = 'Words.db';

  WordsDatabase._init();

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
        "CREATE TABLE $tableWords(${WordFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, ${WordFields.word} TEXT NOT NULL, ${WordFields.meaning} TEXT NOT NULL, ${WordFields.tag} TEXT NOT NULL, ${WordFields.played} BOOLEAN NOT NULL, ${WordFields.created} TEXT NOT NULL)");
  }

  //CRUD
  void close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;
    final id = await db.insert(tableWords, word.toMap());
    return word.copy(id: id);
  }
  Future<void> clearAll() async {
    final db = await instance.database;
    await db.delete(tableWords);
  }

  Future<Word> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );
    if(maps.isNotEmpty){
      return Word.fromMap(maps.first);
    }
    else{
      throw Exception('not found $id');
    }
  }
  Future<List<Word>> readAll() async {
    final db = await instance.database;
    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
    );
    if(maps.isNotEmpty){
      List<Word> words = [];
      maps.forEach((map) {
        words.add(Word.fromMap(map));
      });
      return words;
    }
    else{
      throw Exception('not found');
    }
  }
}
