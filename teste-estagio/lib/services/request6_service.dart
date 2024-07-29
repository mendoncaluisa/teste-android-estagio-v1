import 'package:http/http.dart' as http;

class Request6Service {
  final String baseUrl;

  Request6Service(this.baseUrl);

  Future<String> fetchParadasPorCorredor(int codigoCorredor) async {
    var url = Uri.parse(
        '$baseUrl/Parada/BuscarParadasPorCorredor?codigoCorredor=$codigoCorredor');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
