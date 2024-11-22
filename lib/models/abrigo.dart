class Abrigo {
  final String id;
  final String nome;
  final String descricao;
  final String endereco;
  final String telefone;
  final String email;
  final String imageUrl;

  Abrigo({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.endereco,
    required this.telefone,
    required this.email,
    required this.imageUrl,
  });

  factory Abrigo.fromJson(String id, Map<String, dynamic> json) {
    return Abrigo(
      id: id,
      nome: json['nome'],
      descricao: json['descricao'],
      endereco: json['endereco'],
      telefone: json['telefone'],
      email: json['email'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'descricao': descricao,
      'endereco': endereco,
      'telefone': telefone,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
