import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/AlimentosDao.dart';
import 'package:fitapp/Calculadora.dart';
import 'package:fitapp/ListaAlimentos.dart';
import 'package:flutter/material.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;

  final AlimentosDao _alimentosDao = AlimentosDao();
  List<Alimentos> _Alimentos = [];

  @override
  void initState() {
    super.initState();
    _loadData(); // Cargar datos de la base de datos
  }

  void _loadData() async {
    _Alimentos = await _alimentosDao.selectAlimento(); // Recuperar Alimentos
    setState(() {});
  }

  void _delAlimentos(int index) async {
    await _alimentosDao
        .deleteAlimento(_Alimentos[index]); // Eliminar de la base de datos
    setState(() {
      _Alimentos.removeAt(index);
    });
  }

  void _insAlimentos(Alimentos newAlimentos) async {
    await _alimentosDao
        .insertAlimentos(newAlimentos); // Insertar en la base de datos
    setState(() {
      _Alimentos.add(newAlimentos);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      Calculadora(
        alimentos: _Alimentos,
      ),
      ListaAlimentos(
        alimentos: _Alimentos,
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
          /*BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Destinos',
          ),*/
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.lightGreen,
        onTap: (index) {
          setState(() {
            _indexSelecionado = index;
          });
        },
      ),
    );
  }
}
