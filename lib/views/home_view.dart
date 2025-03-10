import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/views/mission_list_view.dart';
import 'package:untitled1/views/player_profile_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.player;

    if (player == null) {
      return Scaffold(
        body: Center(
          child: Text(
            "Aucun joueur trouvé",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          /// 🖼 **FOND D'ÉCRAN**
          Positioned.fill(
            child: Image.asset(
              "assets/background.png", // Ajoute ton image ici
              fit: BoxFit.cover,
            ),
          ),

          /// **📜 MENU À GAUCHE**
          Positioned(
            left: 50,
            top: MediaQuery.of(context).size.height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem("▶ JOUER", Colors.red, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MissionsListView()));
                }),
                _buildMenuItem("🛒 SHOP", Colors.white, () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("🛠 Le shop n'est pas encore disponible !")),
                  );
                }),
                _buildMenuItem("👤 JOUEUR", Colors.white, () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PlayerProfileView()));
                }),
              ],
            ),
          ),

          /// **📋 INFO JOUEUR EN HAUT À DROITE**
          Positioned(
            top: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${player.username}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("💻 ${player.hackingPower}", style: _infoStyle()),
                    SizedBox(width: 20),
                    Text("💰 ${player.money}", style: _infoStyle()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **🔹 Fonction pour créer un bouton de menu stylé**
  Widget _buildMenuItem(String title, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: color,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  /// **📌 Style pour les infos en haut à droite**
  TextStyle _infoStyle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  }
}
