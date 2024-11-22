import 'package:flutter/material.dart';
import 'package:projeto_pet/controllers/authController.dart';
import 'package:projeto_pet/views/catalogoPet.dart';
  // Importe sua página de catálogo

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8EF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logotipo
              Center(
                child: Image.asset(
                  'assets/images/pet_amigo_logo.png',
                  height: 100,
                ),
              ),
              const SizedBox(height: 10),
              // Título
              const Text(
                'PET AMIGO',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              // Campos de entrada
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _cpfController,
                      decoration: const InputDecoration(
                        labelText: 'CPF',
                        filled: true,
                        fillColor: Colors.orange,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite seu CPF';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        filled: true,
                        fillColor: Colors.orange,
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite sua senha';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    // Botão Entrar
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB2F77C),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String cpf = _cpfController.text;
                          String password = _passwordController.text;

                          bool loginSuccess = AuthController.login(cpf, password);

                          if (loginSuccess) {
                            // Redireciona para a página de catálogo
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimalCatalogPage(),
                              ),
                            );
                          } else {
                            // Exibe mensagem de erro
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login falhou!')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
