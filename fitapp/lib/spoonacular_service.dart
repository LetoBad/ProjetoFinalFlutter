import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  final String _apiKey =
      '7cfb085203054a8c9158d51c011c5948'; // Coloque a sua chave de API
  final String _baseUrl = 'https://api.spoonacular.com/recipes';

  // Método para buscar receitas por ingrediente
  Future<List<Map<String, dynamic>>> getRecipesByIngredient(
      String ingredient) async {
    final url =
        Uri.parse('$_baseUrl/complexSearch?query=$ingredient&apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List recipes = data['results'];
      return recipes.map((recipe) => recipe as Map<String, dynamic>).toList();
    } else {
      throw Exception('Erro ao carregar receitas');
    }
  }

  // Método para buscar detalhes de uma receita
  Future<Map<String, dynamic>> getRecipeDetails(int id) async {
    final url = Uri.parse('$_baseUrl/$id/information?apiKey=$_apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao carregar detalhes da receita');
    }
  }
}
