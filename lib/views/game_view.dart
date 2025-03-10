import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/enemy_viewmodel.dart';
import '../widgets/enemy_widget.dart';
import '../widgets/player_widget.dart';

class GameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EnemyViewModel()..fetchEnemy(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Clicker Game")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const EnemyWidget(),
              const SizedBox(height: 30),
              const PlayerWidget(playerId: 1), // 🔥 Ajoute l'affichage du joueur
            ],
          ),
        ),
      ),
    );
  }
}
