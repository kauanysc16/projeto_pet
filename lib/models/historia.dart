class Historia {
  final String id;
  final String titulo;
  final String descricao;
  final String imageUrl;

  Historia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.imageUrl,
  });

  factory Historia.fromJson(String id, Map<String, dynamic> json) {
    return Historia(
      id: id,
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'imageUrl': imageUrl,
    };
  }
}
