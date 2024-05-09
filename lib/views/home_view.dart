import 'package:estudo_sql/views/tarefas_concluided.dart';
import 'package:estudo_sql/views/tarefas_list.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> _telas = [
    const TarefasList(),
    const TarefasConcluided(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Concluídas')
        ],
      ),
    );
  }
}
