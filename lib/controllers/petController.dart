import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/pet.dart';

class PetController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Pet> getPet(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('pets').doc(id).get();
      if (doc.exists) {
        return Pet.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        throw Exception('Pet não encontrado');
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Pet>> getPets() {
    return _firestore.collection('pets').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Pet.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addPet(Pet pet) {
    return _firestore.collection('pets').add(pet.toMap());
  }

  Future<void> updatePet(Pet pet) {
    return _firestore.collection('pets').doc(pet.id).update(pet.toMap());
  }

  Future<void> deletePet(String id) {
    return _firestore.collection('pets').doc(id).delete();
  }
}
