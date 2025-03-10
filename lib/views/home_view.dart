import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/views/mission_list_view.dart';
import 'package:untitled1/views/player_profile_view.dart'; // Nouvelle page pour gérer le joueur

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.player;

    if (player == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Hacking Clicker")),
        body: Center(child: Text("Aucun joueur trouvé", style: TextStyle(fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Menu Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue, ${player.username} !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${player.hackingPower}"),
            Text("💰 Argent : ${player.money}"),
            SizedBox(height: 40),

            /// 🏆 BOUTON : LISTE DES MISSIONS
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MissionsListView()),
                );
              },
              child: Text("📋 Missions"),
            ),
            SizedBox(height: 10),

            /// 🛒 BOUTON : SHOP (en attente)
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("🛠 Le shop n'est pas encore disponible !")),
                );
              },
              child: Text("🛒 Shop"),
            ),
            SizedBox(height: 10),

            /// 👤 BOUTON : GÉRER MON JOUEUR
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlayerProfileView()),
                );
              },
              child: Text("👤 Joueur"),
            ),
          ],
        ),
      ),
    );
  }
}
