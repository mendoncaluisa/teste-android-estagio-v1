class Corredor {
  final int cc;
  final String nc;

  Corredor({required this.cc, required this.nc});

  factory Corredor.fromJson(Map<String, dynamic> json) {
    return Corredor(
      cc: json['cc'],
      nc: json['nc'],
    );
  }
}
