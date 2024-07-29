import 'package:http/http.dart' as http;

class Request10Service {
  final String baseUrl;

  Request10Service(this.baseUrl);

  Future<String> fetchPosicaoGaragem(int codigoEmpresa, int codigoLinha) async {
    print(codigoEmpresa);
    print(codigoLinha);
    var url = Uri.parse(
        '$baseUrl/Posicao/Garagem?codigoEmpresa=$codigoEmpresa&codigoLinha=$codigoLinha');
    var request = http.Request('GET', url);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      return responseBody;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
