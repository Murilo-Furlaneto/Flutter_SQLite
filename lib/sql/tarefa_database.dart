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
      version: 2,
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
    if (oldVersion < 2) {
await db.execute('ALTER TABLE tarefa ADD COLUMN description TEXT');
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
    final List<Map<String, dynamic>> maps = await db.query('tarefa');

    return List.generate(
        maps.length, (index) => TarefasModels.fromMap(maps[index]));
  }
}
