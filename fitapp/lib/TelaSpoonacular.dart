import 'package:flutter/material.dart';
import 'package:fitapp/Spoonacular_Service.dart';

class TelaSpoonacular extends StatefulWidget {
  @override
  _TelaSpoonacularState createState() => _TelaSpoonacularState();
}

class _TelaSpoonacularState extends State<TelaSpoonacular> {
  List<Map<String, dynamic>> _receitas = [];
  String _resultado = '';

  @override
  void initState() {
    super.initState();
    _carregarReceitas();
  }

  //carregar as receitas da api
  void _carregarReceitas() async {
    try {
      var receitas = await SpoonacularService().getRecipes();

      // Garantir que o tipo é uma lista
      if (receitas is List<Map<String, dynamic>>) {
        setState(() {
          _receitas = receitas;
          _resultado = receitas.isNotEmpty
              ? 'Receitas carregadas!'
              : 'Nenhuma receita encontrada!';
        });
      } else {
        throw Exception('Formato de dados inválido');
      }
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao carregar receitas: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receitas da API"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(_resultado),
            const SizedBox(height: 20),
            // mostrando a lista de receitas
            Expanded(
              child: ListView.builder(
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  final receita = _receitas[index];
                  return ListTile(
                    title: Text(receita['title']),
                    subtitle: Text(
                        'Tempo de preparo: ${receita['readyInMinutes']} min'),
                    leading: receita['image'] != null
                        ? Image.network(receita['image'], width: 50, height: 50)
                        : Icon(Icons.image),
                    onTap: () {
                      // se quiser pode ver os detalhes da receita
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(receita['title']),
                          content: Text('Mais detalhes sobre a receita.'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
