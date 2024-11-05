import 'package:fitapp/Alimentos.dart';

class AlimentosDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> insertAlimentos(Alimentos alimentos) async {
    final db = await _dbHelper.database;
    await db.insert(
      'Alimentos',
      alimentos.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateAlimentos(Alimentos alimentos) async {
    final db = await _dbHelper.database;
    await db.update(
      'Alimentos',
      alimentos.toMap(),
      where: 'id = ?',
      whereArgs: [alimentos.id],
    );
  }

  Future<void> deleteAlimento(Alimentos alimentos) async {
    final db = await _dbHelper.database;
    await db.delete(
      'Alimentos',
      where: 'id = ?',
      whereArgs: [alimentos.id],
    );
  }

  Future<List<Alimentos>> selectAlimento() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('alimentos');

    return List.generate(tipoJSON.length, (i) {
      return Alimentos.fromMap(tipoJSON[i]);
    });
  }
}