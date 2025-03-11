import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import 'home_view.dart';

class CreatePlayerView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  CreatePlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Créer un hacker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Entrez votre pseudo :", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nom de hacker",
              ),
            ),
            const SizedBox(height: 20),
            playerViewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text.trim();
                if (username.isNotEmpty) {
                  bool success = await playerViewModel.createPlayer(username);
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeView()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("❌ Échec de la création du joueur.")),
                    );
                  }
                }
              },
              child: const Text("Créer mon hacker"),
            ),
          ],
        ),
      ),
    );
  }
}