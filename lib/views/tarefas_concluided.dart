import 'package:estudo_sql/controller/tarefas_controller.dart';
import 'package:estudo_sql/models/tarefas_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasConcluided extends StatefulWidget {
  const TarefasConcluided({super.key});

  @override
  State<TarefasConcluided> createState() => _TarefasConcluidedState();
}

class _TarefasConcluidedState extends State<TarefasConcluided> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarefasController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas concluídas'),
        centerTitle: true,
        backgroundColor: ThemeData().primaryColor,
      ),
      body: FutureBuilder(
        future: provider.tarefasConcluidas(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TarefasModels>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar os dados'),
            );
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma tarefa concluída'),
            );
          } else {
            List<TarefasModels> tarefasConcluidas = snapshot.data!;
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(tarefasConcluidas[index].description),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemCount: tarefasConcluidas.length);
          }
        },
      ),
    );
  }
}
