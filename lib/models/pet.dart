class Pet {
  final String id;
  final String nome;
  final String raca;
  final int idade;
  final String descricao;
  final String imageUrl;
  final String abrigoId; // ID do abrigo

  Pet({
    required this.id,
    required this.nome,
    required this.raca,
    required this.idade,
    required this.descricao,
    required this.imageUrl,
    required this.abrigoId,
  });

  factory Pet.fromMap(Map<String, dynamic> data, String id) {
    return Pet(
      id: id,
      nome: data['nome'] ?? '',
      raca: data['raca'] ?? '',
      idade: data['idade'] ?? 0,
      descricao: data['descricao'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      abrigoId: data['abrigoId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'raca': raca,
      'idade': idade,
      'descricao': descricao,
      'imageUrl': imageUrl,
      'abrigoId': abrigoId,
    };
  }
}
