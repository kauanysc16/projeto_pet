// controllers/notificacao_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/notificacao.dart';

class NotificacaoController {
  final CollectionReference _notificacaoCollection =
      FirebaseFirestore.instance.collection('notificacoes');

  // Adiciona uma nova notificação
  Future<void> addNotificacao(Notificacao notificacao) async {
    try {
      await _notificacaoCollection.add(notificacao.toJson());
      print('Notificação adicionada com sucesso!');
    } catch (e) {
      print('Erro ao adicionar notificação: $e');
    }
  }

  // Obtém todas as notificações em tempo real
  Stream<List<Notificacao>> getNotificacoes() {
    return _notificacaoCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Notificacao.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Marca uma notificação como lida
  Future<void> marcarComoLida(String id) async {
    try {
      await _notificacaoCollection.doc(id).update({'lida': true});
      print('Notificação marcada como lida!');
    } catch (e) {
      print('Erro ao marcar notificação como lida: $e');
    }
  }
}
