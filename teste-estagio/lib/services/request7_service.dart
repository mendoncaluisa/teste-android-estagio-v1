import 'package:http/http.dart' as http;

class Request7Service {
  final String baseUrl;

  Request7Service(this.baseUrl);

  Future<String> fetchPosicaoVeiculos() async {
    var url = Uri.parse('$baseUrl/Posicao');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
