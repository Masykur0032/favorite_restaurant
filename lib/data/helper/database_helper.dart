import 'package:fav_resto/data/model/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper {
  static late DbHelper _dbHelper;
  static late Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'favorite.db';
    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorite (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      idfavorit TEXT,
      name TEXT,
      desc TEXT,
      urlimage TEXT,
      city TEXT,
      rating TEXT,
      foods TEXT,
      drinks TEXT
    )
    ''');
  }

  //select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('favorite', orderBy: 'name');
    return mapList;
  }

  //create databases
  Future<int> insert(Favorite object) async {
    Database db = await this.initDb();
    int count = await db.insert('favorite', object.toMap());
    return count;
  }

  //update databases
  Future<int> update(Favorite object) async {
    Database db = await this.initDb();
    int count = await db.update('favorite', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('favorite', where: 'id=?', whereArgs: [id]);
    return count;
  }

  // Future<List<Favorite>> getItemList() async {
  //   var itemMapList = await select();
  //   int count = itemMapList.length;
  //   List<Favorite> itemList = List<Favorite>(count);
  //   for (int i = 0; i < count; i++) {
  //     itemList.add(Favorite.fromMap(itemMapList[i]));
  //   }
  //   return itemList;
  // }

  Future<List<Favorite>> getFavoriteList() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query('favorite');

    return results.map((res) => Favorite.fromMap(res)).toList();
  }

  factory DbHelper() {
    /*
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    */
    _dbHelper = DbHelper._createObject();
    return _dbHelper;
  }

  Future<Database> get database async {
    /*
    if (_database == null) {
      _database = await initDb();
    }
    */
    _database = await initDb();
    return _database;
  }
}

// import 'package:fav_resto/data/model/favorite.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static DatabaseHelper? _databaseHelper;
//   static late Database _database;

//   DatabaseHelper._internal() {
//     _databaseHelper = this;
//   }

//   factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

//   static String _tableName = 'favorite';

//   Future<Database> _initializeDb() async {
//     var path = await getDatabasesPath();
//     var db = openDatabase(
//       join(path, 'favorite_db.db'),
//       onCreate: (db, version) async {
//         await db.execute(
//           '''CREATE TABLE $_tableName (
//                id INTEGER PRIMARY KEY,
//                idFavorite TEXT,
//       name TEXT,
//       urlImage TEXT,
//       city TEXT,
//       rating TEXT
//              )''',
//         );
//       },
//       version: 1,
//     );

//     return db;
//   }

//   Future<Database> get database async {
//     _database = await _initializeDb();
//     return _database;
//   }

//   Future<void> insertFavorite(Favorite favorite) async {
//     final Database db = await database;
//     await db.insert(_tableName, favorite.toMap());
//     print('Data saved');
//   }

//   Future<List<Favorite>> getFavorite() async {
//     final Database db = await database;
//     List<Map<String, dynamic>> results = await db.query(_tableName);

//     return results.map((res) => Favorite.fromMap(res)).toList();
//   }

//   Future<Favorite> getFavoriteById(int id) async {
//     final Database db = await database;
//     List<Map<String, dynamic>> results = await db.query(
//       _tableName,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     return results.map((res) => Favorite.fromMap(res)).first;
//   }

//   Future<void> updateFavorite(Favorite favorite) async {
//     final db = await database;

//     await db.update(
//       _tableName,
//       favorite.toMap(),
//       where: 'id = ?',
//       whereArgs: [favorite.id],
//     );
//   }

//   Future<void> deleteFavorite(int id) async {
//     final db = await database;

//     await db.delete(
//       _tableName,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
