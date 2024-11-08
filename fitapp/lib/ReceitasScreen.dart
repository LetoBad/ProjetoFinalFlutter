import 'package:flutter/material.dart';
import 'TheMealDBService.dart';

class ReceitasScreen extends StatefulWidget {
  @override
  _ReceitasScreenState createState() => _ReceitasScreenState();
}

class _ReceitasScreenState extends State<ReceitasScreen> {
  List<Map<String, dynamic>> _recipes = [];
  String _resultado = '';

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  // Cargar todas las recetas
  void _loadRecipes() async {
    try {
      final recipes = await TheMealDBService().getAllRecipes();
      setState(() {
        _recipes = recipes;
        _resultado = recipes.isNotEmpty
            ? 'Recetas cargadas!'
            : 'No se encontraron recetas';
      });
    } catch (e) {
      setState(() {
        _resultado = 'Error al cargar recetas: $e';
      });
    }
  }

  // Mostrar detalles de la receta
  void _showRecipeDetails(String id) async {
    try {
      final details = await TheMealDBService().getRecipeDetails(id);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(details['strMeal']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(details['strMealThumb']),
              Text('Categoría: ${details['strCategory']}'),
              Text('Área: ${details['strArea']}'),
              SizedBox(height: 10),
              Text('Instrucciones:'),
              Text(details['strInstructions']),
            ],
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar detalles de la receta: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recetas Disponibles')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_resultado),
            SizedBox(height: 16),
            Expanded(
              child: _recipes.isEmpty
                  ? Center(child: Text('No se encontraron recetas'))
                  : ListView.builder(
                      itemCount: _recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = _recipes[index];
                        return ListTile(
                          title: Text(recipe['strMeal']),
                          leading: recipe['strMealThumb'] != null
                              ? Image.network(recipe['strMealThumb'],
                                  width: 50, height: 50)
                              : Icon(Icons.image),
                          onTap: () => _showRecipeDetails(recipe['idMeal']),
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
