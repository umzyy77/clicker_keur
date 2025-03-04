import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';

class PlayerWidget extends StatelessWidget {
  final int playerId;

  const PlayerWidget({Key? key, required this.playerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerViewModel()..fetchPlayer(playerId),
      child: Consumer<PlayerViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const CircularProgressIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Pseudo: ${viewModel.player.pseudo}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text("XP: ${viewModel.player.totalExperience}", style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => viewModel.addExperience(playerId),
                      child: const Text("Gagner XP"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => viewModel.buyEnhancement(2), // 🔥 ID fixe (à rendre dynamique)
                      child: const Text("Acheter Amélioration"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
