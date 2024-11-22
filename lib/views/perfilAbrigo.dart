import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShelterProfilePage extends StatelessWidget {
  final String shelterId;

  ShelterProfilePage({required this.shelterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Cor de fundo mais suave
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0097B2), // Cor personalizada para o appBar
        title: const Text(
          'Perfil do Abrigo',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('shelters')
            .doc(shelterId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  const Text(
                    'Erro ao carregar os dados. Tente novamente.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final shelterData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagem do Abrigo com borda arredondada
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      shelterData['imageUrl'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Nome do Abrigo com estilo personalizado
                  Text(
                    shelterData['name'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1ABAF0), // Cor do nome
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Descrição do Abrigo
                  Text(
                    shelterData['description'] ?? 'Sem descrição disponível.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 32),
                  // Botão de ação (por exemplo, para entrar em contato ou visitar)
                  ElevatedButton(
                    onPressed: () {
                      // Ação do botão, pode ser um link para contato, visita, etc.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1ABAF0),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Entrar em Contato',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
