import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  final String _apiKey = '7cfb085203054a8c9158d51c011c5948'; // Sua chave de API
  final String _baseUrl = 'https://api.spoonacular.com/recipes';

  // Função para buscar todas as receitas (sem filtros)
  Future<List<Map<String, dynamic>>> getRecipes() async {
    final url = '$_baseUrl/complexSearch?apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Verificar se existe a chave 'results' e garantir que é uma lista
        if (data.containsKey('results') && data['results'] is List) {
          List<Map<String, dynamic>> receitas = [];

          // Iterando sobre os resultados e verificando se cada item é um Map
          for (var receita in data['results']) {
            if (receita is Map<String, dynamic>) {
              receitas.add(receita);
            } else {
              print('Item não é um Map: $receita');
            }
          }

          return receitas;
        } else {
          throw Exception(
              'Nenhuma receita encontrada ou formato inválido na resposta da API');
        }
      } else {
        throw Exception(
            'Falha ao carregar receitas, status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar receitas: $e');
    }
  }

  // Função para buscar os detalhes de uma receita pelo ID
  Future<Map<String, dynamic>> getRecipeDetails(int id) async {
    final url = '$_baseUrl/$id/information?apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data; // Retorna os detalhes da receita
      } else {
        throw Exception('Falha ao carregar detalhes da receita');
      }
    } catch (e) {
      throw Exception('Erro ao buscar detalhes da receita: $e');
    }
  }
}
