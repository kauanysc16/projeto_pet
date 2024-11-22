import 'package:cloud_firestore/cloud_firestore.dart';

class Notificacao {
  final String id;
  final String titulo;
  final String descricao;
  final DateTime data;
  final bool lida;

  Notificacao({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.lida,
  });

  // Converte os dados do Firestore para o modelo Notificacao
  factory Notificacao.fromJson(String id, Map<String, dynamic> json) {
    return Notificacao(
      id: id,
      titulo: json['titulo'] ?? '',
      descricao: json['descricao'] ?? '',
      data: (json['data'] as Timestamp).toDate(), // Converte o Timestamp para DateTime
      lida: json['lida'] ?? false,
    );
  }

  // Converte o modelo Notificacao para JSON para salvar no Firestore
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'data': Timestamp.fromDate(data), // Converte DateTime para Timestamp
      'lida': lida,
    };
  }
}
