import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitapp.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Alimentos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            calorias REAL,
            proteinas REAL,
            carbo REAL,
            gordura REAL
          )
        ''');
      },
      version: 1,
    );
  }
}
