import 'package:http/http.dart' as http;

class Request13Service {
  final String baseUrl;

  Request13Service(this.baseUrl);

  Future<String> fetchPrevisao(int codigoParada, int codigoLinha) async {
    var url = Uri.parse(
        '$baseUrl/Previsao/?codigoParada=$codigoParada?codigoLinha=$codigoLinha');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
