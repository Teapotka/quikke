import 'package:sqflite/sqflite.dart';

abstract class ModelDatabase<T>{
  Future<Database> get database;

  void close();
  Future<T> create(T model);
  Future<void> clearAll();
  Future<T> read(int id);
  Future<List<T>> readAll();
}