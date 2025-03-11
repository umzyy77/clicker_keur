import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/views/mission_list_view.dart';
import 'package:untitled1/views/player_profile_view.dart';
import 'package:untitled1/views/shop_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final Map<String, bool> _hoverState = {
    "▶ JOUER": false,
    "🛒 SHOP": false,
    "👤 JOUEUR": false,
  };

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final player = playerViewModel.player;
    final screenSize = MediaQuery.of(context).size;

    String backgroundImage = screenSize.width > 600
        ? "assets/background_pc.png"
        : "assets/background_mobile.png";

    if (player == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Aucun joueur trouvé",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: screenSize.width * 0.08,
            top: screenSize.height * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenuItem("▶ JOUER", () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MissionsListView()));
                }),
                _buildMenuItem("🛒 SHOP", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopView()));
                }),
                _buildMenuItem("👤 JOUEUR", () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PlayerProfileView()));
                }),
              ],
            ),
          ),

          Positioned(
            top: screenSize.height * 0.05,
            right: screenSize.width * 0.05,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  player.username,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    _buildInfoText("💻 ${player.hackingPower}"),
                    const SizedBox(width: 20),
                    _buildInfoText("💰 ${player.money}"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **🔹 Crée un bouton avec effet hover**
  Widget _buildMenuItem(String title, VoidCallback onPressed) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoverState[title] = true),
      onExit: (_) => setState(() => _hoverState[title] = false),
      child: GestureDetector(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 600 ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: _hoverState[title]! ? Colors.red : Colors.white,
              letterSpacing: 2,
            ),
            child: Text(title),
          ),
        ),
      ),
    );
  }

  /// **📌 Style pour les infos en haut à droite**
  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
