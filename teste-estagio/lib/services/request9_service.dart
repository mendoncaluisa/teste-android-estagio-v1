import 'package:http/http.dart' as http;
import 'dart:convert';
import '/models/empresa.dart';

class Request9Service {
  final String baseUrl;

  Request9Service(this.baseUrl);

  Future<List<Empresa>> fetchEmpresas() async {
    final response = await http.get(Uri.parse('$baseUrl/Empresa'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      // Adicionando depuração

      if (parsed is Map && parsed.containsKey('e')) {
        List<dynamic> areas = parsed['e'];
        List<Empresa> empresas = [];

        for (var area in areas) {
          if (area.containsKey('e')) {
            List<dynamic> empresasArea = area['e'];
            for (var empresaJson in empresasArea) {
              empresas.add(Empresa.fromJson(empresaJson));
            }
          }
        }
        return empresas;
      } else {
        throw Exception('Resposta inesperada do servidor');
      }
    } else {
      throw Exception('Failed to load empresas');
    }
  }
}
