import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Alimentos.dart';

class AlimentosDao {
  // Método para obtener o inicializar la base de datos
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'fitapp.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE alimentos(nome TEXT PRIMARY KEY, calorias REAL, proteinas REAL, carbo REAL, gordura REAL)',
        );
      },
      version: 1,
    );
  }

  // Método para insertar un alimento en la base de datos
  Future<void> insertAlimentos(Alimentos alimento) async {
    final db = await getDatabase();
    await db.insert(
      'alimentos',
      alimento.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para obtener todos los alimentos
  Future<List<Alimentos>> selectAlimento() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('alimentos');
    return List.generate(maps.length, (i) {
      return Alimentos.fromMap(maps[i]);
    });
  }

  // Método para eliminar un alimento específico
  Future<void> deleteAlimento(Alimentos alimento) async {
    final db = await getDatabase();
    await db.delete(
      'alimentos',
      where: 'nome = ?',
      whereArgs: [alimento.nome],
    );
  }
}
