import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_pet/views/catalogoPet.dart';
import 'package:projeto_pet/views/historiasView.dart';
import 'package:projeto_pet/views/notificacao.dart';
import 'package:projeto_pet/views/perfilAbrigo.dart';
import 'package:projeto_pet/views/visitasView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PetAmigoApp());
}

class PetAmigoApp extends StatelessWidget {
  const PetAmigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Amigo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithDrawer(
      body: CatalogoPet(), // Página inicial exibida por padrão
    );
  }
}

class ScaffoldWithDrawer extends StatelessWidget {
  final Widget body;

  const ScaffoldWithDrawer({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Amigo'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.pets),
              title: const Text('Catálogo'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ScaffoldWithDrawer(body: CatalogoPet())),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Histórias'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScaffoldWithDrawer(body: HistoriasView())),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificações'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScaffoldWithDrawer(body: Notificacao())),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Abrigo'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ScaffoldWithDrawer(body: AbrigoPerfil(abrigoId: '1'))),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Visitas'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ScaffoldWithDrawer(body: VisitasView(petId: '1', abrigoId: '1'))),
                );
              },
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
