import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/AlimentosDao.dart';
import 'package:fitapp/Calculadora.dart';
import 'package:fitapp/ListaAlimentos.dart';
import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  int _indexSelecionado = 0;

  final AlimentosDao _alimentosDao = AlimentosDao();
  List<Alimentos> _alimentos = [];

  @override
  void initState() {
    super.initState();
    _loadData(); // Cargar datos de la base de datos
  }

  Future<void> _loadData() async {
    final alimentos =
        await _alimentosDao.selectAlimento(); // Recuperar Alimentos
    setState(() {
      _alimentos = alimentos;
    });
  }

  Future<void> _delAlimentos(int index) async {
    await _alimentosDao
        .deleteAlimento(_alimentos[index]); // Eliminar de la base de datos
    setState(() {
      _alimentos.removeAt(index);
    });
  }

  Future<void> _insAlimentos(Alimentos newAlimentos) async {
    await _alimentosDao
        .insertAlimentos(newAlimentos); // Insertar en la base de datos
    setState(() {
      _alimentos.add(newAlimentos);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Calculadora(
        alimentos: _alimentos,
      ),
      ListaAlimentos(
        alimentos: _alimentos,
        onRemove: _delAlimentos,
        onInsert: _insAlimentos,
      ),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions[_indexSelecionado],
      ),
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
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.lightGreen,
        onTap: (index) => setState(() => _indexSelecionado = index),
      ),
    );
  }
}
