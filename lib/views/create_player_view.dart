import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import 'home_view.dart';

class CreatePlayerView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Créer un hacker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Entrez votre pseudo :", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nom de hacker",
              ),
            ),
            SizedBox(height: 20),
            playerViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text.trim();
                if (username.isNotEmpty) {
                  bool success = await playerViewModel.createPlayer(username);
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("❌ Échec de la création du joueur.")),
                    );
                  }
                }
              },
              child: Text("Créer mon hacker"),
            ),
          ],
        ),
      ),
    );
  }
}
