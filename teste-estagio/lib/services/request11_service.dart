import 'package:http/http.dart' as http;

class Request11Service {
  final String baseUrl;

  Request11Service(this.baseUrl);

  Future<String> fetchPrevisaoParada(int codigoParada) async {
    var url = Uri.parse('$baseUrl/Previsao/Parada?codigoParada=$codigoParada');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
