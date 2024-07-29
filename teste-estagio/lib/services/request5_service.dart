import '/models/corredor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Request5Service {
  final String baseUrl;

  Request5Service(this.baseUrl);

  Future<List<Corredor>> fetchCorredores() async {
    var url = Uri.parse('$baseUrl/Corredor');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Corredor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
