import 'package:flutter/material.dart';
import 'package:fitapp/Spoonacular_Service.dart'; // Importando o serviço da API

class ReceitasScreen extends StatefulWidget {
  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _recipes = [];

  // Função para buscar receitas
  void _searchRecipes() async {
    final ingredient = _controller.text.trim();
    if (ingredient.isEmpty) return;

    try {
      final recipes =
          await SpoonacularService().getRecipesByIngredient(ingredient);
      setState(() {
        _recipes = recipes;
      });
    } catch (e) {
      // Lidar com erro
      print('Erro ao carregar receitas: $e'); // Log de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar receitas')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscar Receitas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite um ingrediente',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchRecipes,
                ),
              ),
            ),
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
                            // Verificando os detalhes da receita
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
