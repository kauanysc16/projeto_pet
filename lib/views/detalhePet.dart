import 'package:flutter/material.dart';
import 'package:projeto_pet/controllers/petController.dart';
import 'package:projeto_pet/models/pet.dart';

class DetalhePet extends StatelessWidget {
  final String petId;
  final PetController _petController = PetController(); // Inicialização correta

  DetalhePet({required this.petId, super.key}); // Remover 'const'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFAF8EF), // Cor de fundo semelhante às outras páginas
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8EF),
        title: Text(
          'Detalhe do Pet',
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0, // Retirar a sombra do AppBar
      ),
      body: FutureBuilder<Pet>(
        future: _petController
            .getPet(petId), // Método correto para pegar o pet pelo ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Erro ao carregar detalhes do pet'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Pet não encontrado'));
          } else {
            Pet pet = snapshot.data!; // Usando a instância de Pet

            // Verificando se a URL da imagem está vazia ou nula
            Widget petImage = pet.imageUrl.isNotEmpty
                ? Image.network(
                    pet.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  )
                : const Icon(Icons.pets,
                    size: 150.0,
                    color:
                        Colors.orange); // Ícone genérico caso não tenha imagem

            return SingleChildScrollView(
              // Adicionando rolagem
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exibindo a imagem do pet com estilo personalizado
                    Center(child: petImage),
                    const SizedBox(height: 16),
                    Text(
                      pet.nome,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pet.raca,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pet.descricao.isNotEmpty
                          ? pet.descricao
                          : 'Sem descrição disponível.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Botão para adotar o pet
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFB2F77C),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          // Ação de adotar o pet (exemplo)
                        },
                        child: const Text(
                          'ADOTAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
