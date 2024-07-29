import 'package:http/http.dart' as http;

class Request3Service {
  final String baseUrl;

  Request3Service(this.baseUrl);

  Future<String> fetchParadaData(String termosBusca) async {
    var url = Uri.parse('$baseUrl/Parada/Buscar?termosBusca=$termosBusca');

    print('URL da requisição: $url'); // Imprime a URL da requisição

    var request = http.Request('GET', url);
    http.StreamedResponse response = await request.send();

    print(
        'Status da resposta: ${response.statusCode}'); // Imprime o status da resposta

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      print('Resposta recebida: $responseBody'); // Imprime o corpo da resposta
      return responseBody;
    } else {
      print(
          'Erro na resposta: ${response.reasonPhrase}'); // Imprime o erro, se houver
      return response.reasonPhrase ?? 'Unknown error';
    }
  }
}
