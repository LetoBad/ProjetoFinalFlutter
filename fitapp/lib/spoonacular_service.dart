import 'dart:convert';
import 'package:http/http.dart' as http;

class SpoonacularService {
  final String _apiKey =
      '7cfb085203054a8c9158d51c011c5948'; // Coloque sua chave da API
  final String _baseUrl = 'https://api.spoonacular.com/recipes';

  // Método para buscar receitas por ingrediente
  Future<List<String>> buscarReceitas(String ingrediente) async {
    final url = '$_baseUrl/complexSearch?query=$ingrediente&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extrai apenas os nomes das receitas
        List<String> receitas = [];
        for (var receita in data['results']) {
          receitas.add(receita['title']);
        }

        return receitas;
      } else {
        throw Exception('Falha ao carregar receitas');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
