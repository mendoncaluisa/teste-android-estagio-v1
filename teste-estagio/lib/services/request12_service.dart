import 'package:http/http.dart' as http;

class Request12Service {
  final String baseUrl;

  Request12Service(this.baseUrl);

  Future<String> fetchPrevisaoPorLinha(int codigoLinha) async {
    var url = Uri.parse('$baseUrl/Previsao/Linha?codigoLinha=$codigoLinha');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
