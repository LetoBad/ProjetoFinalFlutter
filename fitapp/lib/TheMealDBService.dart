import 'dart:convert';
import 'package:http/http.dart' as http;

class TheMealDBService {
  final String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Obtener todas las recetas
  Future<List<Map<String, dynamic>>> getAllRecipes() async {
    final url = '$_baseUrl/search.php?s=';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['meals'] != null) {
          return List<Map<String, dynamic>>.from(data['meals']);
        } else {
          throw Exception('No se encontraron recetas');
        }
      } else {
        throw Exception('Error al cargar recetas');
      }
    } catch (e) {
      throw Exception('Error al buscar recetas: $e');
    }
  }

  // Obtener detalles de una receta específica
  Future<Map<String, dynamic>> getRecipeDetails(String id) async {
    final url = '$_baseUrl/lookup.php?i=$id';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['meals'] != null && data['meals'].isNotEmpty) {
          return data['meals'][0];
        } else {
          throw Exception('No se encontró la receta');
        }
      } else {
        throw Exception('Error al cargar detalles');
      }
    } catch (e) {
      throw Exception('Error al obtener detalles: $e');
    }
  }
}
