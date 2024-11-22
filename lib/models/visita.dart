import 'package:cloud_firestore/cloud_firestore.dart';

class Visita {
  final String id;
  final String visitanteId;  // ID do usuário que está visitando
  final String abrigoId;     // ID do abrigo
  final DateTime dataVisita;
  final String motivo;
  final String observacoes;

  Visita({
    required this.id,
    required this.visitanteId,
    required this.abrigoId,
    required this.dataVisita,
    required this.motivo,
    required this.observacoes,
  });

  // Converte os dados do Firestore para o modelo Visita
  factory Visita.fromJson(String id, Map<String, dynamic> json) {
    return Visita(
      id: id,
      visitanteId: json['visitanteId'] ?? '',
      abrigoId: json['abrigoId'] ?? '',
      dataVisita: (json['dataVisita'] as Timestamp).toDate(), // Converte Timestamp para DateTime
      motivo: json['motivo'] ?? '',
      observacoes: json['observacoes'] ?? '',
    );
  }

  // Converte o modelo Visita para JSON para salvar no Firestore
  Map<String, dynamic> toJson() {
    return {
      'visitanteId': visitanteId,
      'abrigoId': abrigoId,
      'dataVisita': Timestamp.fromDate(dataVisita), // Converte DateTime para Timestamp
      'motivo': motivo,
      'observacoes': observacoes,
    };
  }
}
