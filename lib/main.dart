import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> testApi() async {
    try {
      final response = await ApiService.getRequest("/enemies");
      print("Réponse API : $response");
    } catch (e) {
      print("Erreur : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    testApi(); // 🔥 Teste la connexion à Flask au démarrage

    return MaterialApp(
      title: 'Clicker Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Test API Flask")),
        body: Center(child: Text("Vérifie la console pour voir la réponse")),
      ),
    );
  }
}
