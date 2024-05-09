import 'dart:math';
import 'package:estudo_sql/controller/tarefas_controller.dart';
import 'package:estudo_sql/models/tarefas_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasForm extends StatefulWidget {
  const TarefasForm({Key? key});

  @override
  State<TarefasForm> createState() => _TarefasFormState();
}

class _TarefasFormState extends State<TarefasForm> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: const Text('Cadastrar tarefa'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: "Descrição",
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * .5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  if (_descriptionController.text.isEmpty) {
                    return;
                  } else {
                    var novaTarefa = TarefasModels(
                      id: Random().nextInt(10000),
                      description: _descriptionController.text, isConcluided: false,
                    );

                    final provider = Provider.of<TarefasController>(
                      context,
                      listen: false,
                    );

                    provider.adicionarTarefa(novaTarefa);
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
