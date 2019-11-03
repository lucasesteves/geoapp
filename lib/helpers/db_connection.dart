import 'package:geo_app/models/place.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper{

  static Future<Database>database() async{
    final dbPath=await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath,'places.db'),onCreate: (db,version){
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT,lat REAL,long REAL)');
    },version: 1);

  }

  static Future<void> addPlace(String table, Map<String,Object>data) async {
    final db=await DBHelper.database();
    db.insert(table,data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>>getData(String table) async{
    final db=await DBHelper.database();
    return db.query(table);
  }
}