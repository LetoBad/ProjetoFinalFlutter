import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Alimentos.dart';

class AlimentosDao {
  late Database _db;

  Future<void> open() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'alimentos.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE alimentos(id INTEGER PRIMARY KEY, nome TEXT, calorias REAL, proteinas REAL, carbo REAL, gordura REAL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertAlimentos(Alimentos alimento) async {
    await _db.insert(
      'alimentos',
      alimento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Alimentos>> selectAlimento() async {
    final List<Map<String, dynamic>> maps = await _db.query('alimentos');
    return List.generate(maps.length, (i) {
      return Alimentos.fromMap(maps[i]);
    });
  }

  Future<void> deleteAlimento(Alimentos alimento) async {
    await _db.delete(
      'alimentos',
      where: 'nome = ?',
      whereArgs: [alimento.nome],
    );
  }

  Future<void> close() async {
    await _db.close();
  }
}
