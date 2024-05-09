import 'package:estudo_sql/controller/tarefas_controller.dart';
import 'package:estudo_sql/models/tarefas_models.dart';
import 'package:estudo_sql/views/tarefas_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasList extends StatefulWidget {
  const TarefasList({super.key});

  @override
  State<TarefasList> createState() => _TarefasListState();
}

class _TarefasListState extends State<TarefasList> {
  

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TarefasController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: const Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: provider.listaTarefas(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TarefasModels>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados'));
          } else {
            List<TarefasModels> tarefas = snapshot.data!;
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: tarefas.length,
              itemBuilder: (BuildContext context, int index) {
                // Constrói um widget para exibir cada tarefa.
                return ListTile(
                  title: Text(tarefas[index].description),
                  trailing: SizedBox(
                    width: 110,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              provider.excluirTarefa(tarefas[index]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                        Switch(
                            value: tarefas[index].isConcluided,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                // Atualize o valor localmente na lista de tarefas exibida
                                tarefas[index].isConcluided = value;
                              });
                              // Atualize os dados da tarefa no provedor de estado
                              provider.atualizarTarefa(tarefas[index]);
                            })
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[400],
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TarefasForm()));
          }),
      
    );
  }
}
