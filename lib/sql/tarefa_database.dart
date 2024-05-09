import 'package:estudo_sql/models/tarefas_models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TarefaDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'tarefa.db'),
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(db, versao) async {
    await db.execute(
      'CREATE TABLE tarefa(id INT PRIMARY KEY, title TEXT)',
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute(
          'ALTER TABLE tarefa ADD COLUMN isConcluided INTEGER NOT NULL DEFAULT 0');
    }
  }

  Future<void> adicionarTarefa(TarefasModels tarefa) async {
    final Database db = await database;

    db.insert('tarefa', tarefa.toMap());
  }

  Future<void> removerTarefa(TarefasModels tarefa) async {
    final Database db = await database;
    db.delete('tarefa', where: 'id = ?', whereArgs: [tarefa.id]);
  }

  Future<List<TarefasModels>> listarTarefas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('tarefa', where: "isConcluided == 0");

    return List.generate(
        maps.length, (index) => TarefasModels.fromMap(maps[index]));
  }

  Future<void> atualizarTarefa(TarefasModels tarefa) async {
    final db = await database;
    await db.update(
      'tarefa',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<List<TarefasModels>> tarefasConcluidas() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('tarefa', where: "isConcluided == 1");

    return List.generate(
        maps.length, (index) => TarefasModels.fromMap(maps[index]));
  }
}
