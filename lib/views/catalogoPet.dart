import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/models/pet.dart';
import 'package:projeto_pet/views/detalhePet.dart';

class AnimalCatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFAF8EF), // Cor de fundo semelhante à página de login
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8EF),
        title: Text(
          'Catálogo de Animais',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0, // Retira a sombra do AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('pets').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar os dados.'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            // Convertendo os documentos do Firestore para uma lista de objetos Pet
            final pets = snapshot.data!.docs.map((doc) {
              return Pet.fromMap(doc.data() as Map<String, dynamic>, doc.id);
            }).toList();

            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: pet.imageUrl.isNotEmpty
                        ? Image.network(pet.imageUrl,
                            width: 60, height: 60, fit: BoxFit.cover)
                        : Icon(Icons.pets, size: 60, color: Colors.orange),
                    title: Text(
                      pet.nome,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      '${pet.raca} - ${pet.idade} anos',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onTap: () {
                      // Navegar para a página de detalhes do pet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhePet(petId: pet.id),
                        ),
                      );
                    },
                    trailing: Icon(Icons.arrow_forward, color: Colors.orange),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
