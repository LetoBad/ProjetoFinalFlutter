import 'package:flutter/material.dart';
import 'package:fitapp/Spoonacular_Service.dart';

class ReceitasScreen extends StatefulWidget {
  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  List<Map<String, dynamic>> _recipes = [];
  String _resultado = '';

  // Carregar todas as receitas
  void _carregarReceitas() async {
    try {
      // Usando a função que busca todas as receitas
      var receitas = await SpoonacularService().getRecipes();
      setState(() {
        _recipes = receitas;
        _resultado = receitas.isNotEmpty
            ? 'Receitas carregadas!'
            : 'Nenhuma receita encontrada!';
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro ao carregar receitas: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Carregar as receitas ao iniciar a tela
    _carregarReceitas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receitas Disponíveis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Exibindo o status da carga das receitas
            Text(_resultado),
            SizedBox(height: 16),
            Expanded(
              child: _recipes.isEmpty
                  ? Center(child: Text('Nenhuma receita encontrada'))
                  : ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return ListTile(
                          title: Text(recipe['title']),
                          subtitle: Text(
                              'Tempo de preparo: ${recipe['readyInMinutes'] ?? 'Desconhecido'} min'),
                          leading: recipe['image'] != null
                              ? Image.network(recipe['image'],
                                  width: 50, height: 50)
                              : Icon(Icons.image),
                          onTap: () async {
                            // Verificar os detalhes da receita
                            try {
                              final details = await SpoonacularService()
                                  .getRecipeDetails(recipe['id']);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(details['title']),
                                  content: Text(
                                    'Ingredientes: ${details['extendedIngredients'].toString()}',
                                  ),
                                ),
                              );
                            } catch (e) {
                              print('Erro ao carregar detalhes: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Erro ao carregar detalhes da receita')),
                              );
                            }
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
