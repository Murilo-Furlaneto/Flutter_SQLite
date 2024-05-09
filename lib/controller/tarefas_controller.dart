import 'package:estudo_sql/models/tarefas_models.dart';
import 'package:estudo_sql/sql/tarefa_database.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier {
  final _database = TarefaDatabase();

  Future<List<TarefasModels>> listaTarefas() async {
    await _database.database;
    return _database.listarTarefas();
  }

  Future<void> adicionarTarefa(TarefasModels tarefa) async {
    await _database.adicionarTarefa(tarefa);
    notifyListeners();
  }

  Future<void> excluirTarefa(TarefasModels tarefa) async {
    await _database.removerTarefa(tarefa);
    notifyListeners();
  }

  Future<void> atualizarTarefa(TarefasModels tarefa) async {
    await _database.atualizarTarefa(tarefa);
    notifyListeners();
  }

  Future<List<TarefasModels>> tarefasConcluidas() async {
    await _database.database;
    return _database.tarefasConcluidas();
  }
}
