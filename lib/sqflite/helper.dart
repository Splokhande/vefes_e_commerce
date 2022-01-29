import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vefes_e_commerce/model/product_detail.dart';

class MyCartHelper {
  static const _databaseName = "myCart.db";
  static const _databaseVersion = 1;

  static const table = 'cart';

  static const id = 'id';
  static const productId = 'product_id';
  static const title = 'title';
  static const price = 'price';
  static const description = 'description';
  static const category = 'category';
  static const image = 'image';
  static const rating = 'rating';
  static const quantity = 'quantity';

  MyCartHelper._privateConstructor();
  static final MyCartHelper instance = MyCartHelper._privateConstructor();
  static Database? _database;

  _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future initDeleteDb(String dbName) async {
    final databasePath = await getDatabasesPath();
    // print(databasePath);
    final path = join(databasePath, dbName);

    // make sure the folder exists
    // ignore: avoid_slow_async_io
    if (await Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
  }

  Future _onCreate(var db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $productId INTEGER PRIMARY KEY AUTOINCREMENT,
            $id INTEGER NOT NULL,
            $title TEXT NOT NULL,
            $quantity INTEGER NOT NULL,
            $price REAL NOT NULL,
            $description TEXT NOT NULL,
            $category TEXT NOT NULL,
            $image TEXT NOT NULL
          )
          ''');
  }

  Future<int> insert(ProductDetailModel details) async {
    var db = await instance.database;
    var res = await db.insert(table, details.toJson(details));
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    var db = await instance.database;
    var res = await db.query(table, orderBy: "$id DESC");
    return res;
  }

  Future<int> delete(int id) async {
    var db = await instance.database;
    return await db.delete(table, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> update(ProductDetailModel model) async {
    Database db = await instance.database;
    int id = model.id!;
    return await db
        .update(table, model.toJson(model), where: '$id = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    var db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }
}
