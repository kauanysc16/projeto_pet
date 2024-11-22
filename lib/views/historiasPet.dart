import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuccessStoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFAF8EF), // Cor de fundo semelhante às outras páginas
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8EF),
        title: Text(
          'Histórias de Sucesso',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0, // Retirar a sombra do AppBar
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('success_stories')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final stories = snapshot.data!.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];

              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5, // Somente a sombra para os cards
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Exibindo a imagem da história
                      story['imageUrl'] != null
                          ? Image.network(
                              story['imageUrl'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.image,
                              size: 80, color: Colors.orange),
                      const SizedBox(width: 16),
                      // Exibindo o título e a descrição da história
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              story['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              story['description'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
