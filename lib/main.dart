import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/views/cadastroPage.dart';
import 'package:projeto_pet/views/notificacaoPet.dart';

// Caminho correto para o arquivo firebase_options.dart
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Remover o banner de debug
      title: 'Pet Amigo',
      theme: ThemeData(
        primarySwatch: Colors.orange,  // Definindo a cor principal como laranja
      ),
      home: const CadastroPage(),   // Inicia com a página de cadastro
    );
  }
}