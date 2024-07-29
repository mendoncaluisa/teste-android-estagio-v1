import 'dart:convert';
import 'package:http/http.dart' as http;

class Request1Service {
  final String baseUrl;

  Request1Service(this.baseUrl);

  Future<List<Map<String, dynamic>>> fetchData(String id) async {
    final url = Uri.parse('$baseUrl/Linha/Buscar?termosBusca=$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Supondo que a resposta é um JSON array
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<
            Map<String, dynamic>>(); // Converta para List<Map<String, dynamic>>
      } else {
        print('Erro ao carregar dados: ${response.statusCode}');
        throw Exception('Falha ao carregar dados');
      }
    } catch (e) {
      print('Erro na requisição: $e');
      throw Exception('Falha ao carregar dados');
    }
  }
}
