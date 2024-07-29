import 'package:http/http.dart' as http;

class Request2Service {
  final String baseUrl;

  Request2Service(this.baseUrl);

  Future<String> fetchLinhaSentidoData(String termosBusca, int sentido) async {
    var url = Uri.parse(
        '$baseUrl/Linha/BuscarLinhaSentido?termosBusca=$termosBusca&sentido=$sentido');
    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase ?? 'Unknown error';
    }
  }
}
