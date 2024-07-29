class Model1 {
  final int id;
  final String name;

  Model1({required this.id, required this.name});

  factory Model1.fromJson(Map<String, dynamic> json) {
    return Model1(
      id: json['id'],
      name: json['name'],
    );
  }
}
