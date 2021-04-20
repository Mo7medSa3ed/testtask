import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database _db;
  static const tableName= 'Products';
  Future<Database> createDatabase() async{
    if(_db != null){
      return _db;
    }
    String path = join(await getDatabasesPath(), 'productsdb.db');
    _db = await openDatabase(path,version: 1,onCreate: (Database db, int v){
      db.execute("create table $tableName(id integer primary key autoincrement,product_name varchar(50), photo text, price double , amount integer)");
    });
    return _db;
  }

  Future<int> createproduct(dynamic product) async{
    Database db = await createDatabase();
    return db.insert(tableName, product);
  }

  Future<List> allproducts() async{
    Database db = await createDatabase();
    return db.query(tableName);
  }
  Future<dynamic> getOneProduct(String name) async{
    Database db = await createDatabase();
    return db.query(tableName,where: 'product_name ==?',whereArgs: [name]);
  }

  Future<int> deleteproduct(int id) async{
    Database db = await createDatabase();
    return db.delete(tableName,where: 'id = ?',whereArgs:[id] );
  }
  Future<int> updateproduct(product,id) async{
    Database db = await createDatabase();
    return db.update(tableName,product,where: 'id = ?',whereArgs:[id] );
  }
  Future<int> deleteAllproduct() async{
    Database db = await createDatabase();
    return db.delete(tableName);
  }
  
}
