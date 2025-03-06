import 'package:flutter/material.dart';
import 'package:hacker_clicker/views/home_view.dart';
import 'package:hacker_clicker/core/services/player_service.dart';
import 'package:hacker_clicker/views/game_view.dart';

import 'core/services/player_mission_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialisation obligatoire

  final playerService = PlayerService();
  int? storedPlayerId = await playerService.getStoredPlayerId();

  runApp(MyApp(storedPlayerId: storedPlayerId));
}

class MyApp extends StatelessWidget {
  final int? storedPlayerId;

  const MyApp({super.key, this.storedPlayerId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hacker Clicker",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: storedPlayerId != null ? const GameView() : const HomeView(), // Redirige si joueur existant
    );
  }
}
