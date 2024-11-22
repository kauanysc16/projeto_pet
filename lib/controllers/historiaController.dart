// controllers/historia_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/historia.dart';

class HistoriaController {
  final CollectionReference _historiaCollection =
      FirebaseFirestore.instance.collection('historias');

  // Adiciona uma nova história
  Future<void> addHistoria(Historia historia) async {
    try {
      await _historiaCollection.add(historia.toJson());
      print('História adicionada com sucesso!');
    } catch (e) {
      print('Erro ao adicionar história: $e');
    }
  }

  // Obtém todas as histórias em tempo real
  Stream<List<Historia>> getHistorias() {
    return _historiaCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Historia.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
