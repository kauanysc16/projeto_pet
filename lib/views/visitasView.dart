import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_pet/models/pet.dart';

class ScheduleVisitPage extends StatelessWidget {
  final Pet pet;

  ScheduleVisitPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _dateController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // Cor de fundo mais suave
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF0097B2), // Cor personalizada para o appBar
        title: const Text(
          'Agendar Visita',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título com nome do pet
              Text(
                'Agende uma visita para o pet: ${pet.nome}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1ABAF0),
                ),
              ),
              const SizedBox(height: 20),
              // Campo de data com ícone de calendário
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Data da Visita',
                  labelStyle: const TextStyle(color: Colors.black87),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.black87),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma data';
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    _dateController.text = pickedDate.toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 20),
              // Botão de agendar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Salva a visita no Firestore
                    FirebaseFirestore.instance.collection('visits').add({
                      'petId': pet.id,
                      'date': _dateController.text,
                    });

                    // Exibe um SnackBar de sucesso
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: const Text('Visita agendada com sucesso!'),
                      backgroundColor: const Color(0xFF1ABAF0),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1ABAF0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Agendar Visita',
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
      ),
    );
  }
}
