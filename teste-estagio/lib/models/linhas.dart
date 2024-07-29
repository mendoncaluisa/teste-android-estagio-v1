class Linha {
  final int cl;
  final String lt;
  final String tp;
  final String ts;

  Linha({
    required this.cl,
    required this.lt,
    required this.tp,
    required this.ts,
  });

  factory Linha.fromJson(Map<String, dynamic> json) {
    return Linha(
      cl: json['cl'],
      lt: json['lt'],
      tp: json['tp'],
      ts: json['ts'],
    );
  }

  static List<Linha> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Linha.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
