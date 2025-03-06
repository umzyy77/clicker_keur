import 'package:flutter/material.dart';
import 'game_view.dart';
import 'shop_view.dart';
import 'mission_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Ambiance terminal hacker
      appBar: AppBar(
        title: const Text("Hacker Clicker"),
        backgroundColor: Colors.greenAccent[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuButton(context, "Démarrer le Hack", Icons.computer, const GameView()),
            _buildMenuButton(context, "Missions", Icons.assignment, const MissionView()),
            _buildMenuButton(context, "Boutique", Icons.shopping_cart, const ShopView()),
          ],
        ),
      ),
    );
  }

  /// Widget pour créer un bouton de menu
  Widget _buildMenuButton(BuildContext context, String text, IconData icon, Widget page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black),
        label: Text(text, style: const TextStyle(color: Colors.black, fontSize: 18)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.greenAccent[400],
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => page),
        ),
      ),
    );
  }
}
