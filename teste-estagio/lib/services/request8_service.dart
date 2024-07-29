import 'package:http/http.dart' as http;

class Request8Service {
  final String baseUrl;

  Request8Service(this.baseUrl);

  Future<String> fetchPosicaoLinha(int codigoLinha) async {
    var url = Uri.parse('$baseUrl/Posicao/Linha?codigoLinha=$codigoLinha');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
