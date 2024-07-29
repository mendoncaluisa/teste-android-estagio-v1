import 'dart:convert';

class Parada {
  final int cp;
  final String np;
  final String ed;
  final double py;
  final double px;

  Parada({
    required this.cp,
    required this.np,
    required this.ed,
    required this.py,
    required this.px,
  });

  // Factory method to create a Parada instance from a JSON map
  factory Parada.fromJson(Map<String, dynamic> json) {
    return Parada(
      cp: json['cp'],
      np: json['np'],
      ed: json['ed'],
      py: json['py'],
      px: json['px'],
    );
  }

  // Convert a Parada instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'cp': cp,
      'np': np,
      'ed': ed,
      'py': py,
      'px': px,
    };
  }

  // Convert a list of JSON maps to a list of Parada instances
  static List<Parada> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Parada.fromJson(json)).toList();
  }
}

void main() {
  // Example usage
  final jsonString = '''
  [
    {
      "cp": 340015329,
      "np": "AFONSO BRAZ B/C1",
      "ed": "R ARMINDA/ R BALTHAZAR DA VEIGA",
      "py": -23.592938,
      "px": -46.672727
    }
  ]
  ''';

  final jsonData = json.decode(jsonString) as List<dynamic>;
  final paradas = Parada.fromJsonList(jsonData);

  for (var parada in paradas) {
    print('${parada.cp} - ${parada.np} - ${parada.ed}');
  }
}
