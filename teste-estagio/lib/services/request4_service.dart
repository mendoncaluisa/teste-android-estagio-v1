import 'package:http/http.dart' as http;

class Request4Service {
  final String baseUrl;

  Request4Service(this.baseUrl);

  Future<String> fetchParadasPorLinhaData(int codigoLinha) async {
    var url = Uri.parse(
        '$baseUrl/Parada/BuscarParadasPorLinha?codigoLinha=$codigoLinha');
    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return response.reasonPhrase ?? 'Unknown error';
    }
  }
}
