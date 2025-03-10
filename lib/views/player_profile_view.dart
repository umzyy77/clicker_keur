import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';

class PlayerProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.player;

    if (player == null) {
      return Scaffold(
        appBar: AppBar(title: Text("👤 Profil joueur")),
        body: Center(child: Text("Aucun joueur trouvé.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("👤 Profil Joueur")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom : ${player.username}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${player.hackingPower}"),
            Text("💰 Argent : ${player.money}"),
            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await playerViewModel.deletePlayer();
                Navigator.pop(context); // Retourner au menu après suppression
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("❌ Supprimer mon joueur"),
            ),
          ],
        ),
      ),
    );
  }
}
