import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/AlimentosDao.dart';
import 'package:fitapp/Calculadora.dart';
import 'package:fitapp/ListaAlimentos.dart';
import 'package:fitapp/TelaSpoonacular.dart'; // Importando a tela que consome a API
import 'package:flutter/material.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;
  final AlimentosDao _alimentosDao = AlimentosDao();
  List<Alimentos> _alimentos = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await _alimentosDao.open(); // Abre o banco de dados
    _alimentos = await _alimentosDao.selectAlimento(); // Carrega os alimentos
    setState(() {});
  }

  void _delAlimentos(int index) async {
    await _alimentosDao.deleteAlimento(_alimentos[index]);
    setState(() {
      _alimentos.removeAt(index); // Remove alimento da lista
    });
  }

  void _insAlimentos(Alimentos alimento) async {
    await _alimentosDao.insertAlimentos(alimento); // Insere alimento no banco
    setState(() {
      _alimentos.add(alimento); // Adiciona alimento à lista
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Calculadora(alimentos: _alimentos), // Tela de Cálculo
      ListaAlimentos(
        alimentos: _alimentos,
        onRemove: _delAlimentos,
        onInsert: _insAlimentos,
      ), // Lista de alimentos
      TelaSpoonacular(), // Nova tela para consumir a API
    ];

    return Scaffold(
      body: widgetOptions[_indexSelecionado], // Exibe a tela selecionada
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'Receitas API',
          ),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.lightGreen,
        onTap: (index) {
          setState(() {
            _indexSelecionado = index; // Atualiza o índice da navegação
          });
        },
      ),
    );
  }
}
