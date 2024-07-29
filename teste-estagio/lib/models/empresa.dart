class Empresa {
  final String n; // Nome da empresa
  final int c;

  Empresa({required this.n, required this.c});

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      n: json['n'],
      c: json['c'],
    );
  }
}
