import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_viewmodel.dart';
import '../viewmodels/player_mission_viewmodel.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _loadPlayerAndMissions();
  }

  Future<void> _loadPlayerAndMissions() async {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context, listen: false);
    await playerViewModel.loadPlayer();
    if (playerViewModel.player != null) {
      await playerMissionViewModel.loadPlayerMissions(playerViewModel.player!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Hacking Clicker")),
      body: Center(
        child: playerViewModel.isLoading
            ? CircularProgressIndicator()
            : playerViewModel.player == null
            ? Text("Aucun joueur trouvé", style: TextStyle(fontSize: 18))
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bienvenue, ${playerViewModel.player!.username} !",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("💻 Puissance de hacking : ${playerViewModel.player!.hackingPower}"),
            Text("💰 Argent : ${playerViewModel.player!.money}"),
            SizedBox(height: 20),
            Text("📋 Missions disponibles :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            playerMissionViewModel.isLoading
                ? CircularProgressIndicator()
                : playerMissionViewModel.playerMissions.isEmpty
                ? Text("Aucune mission disponible")
                : Expanded(
              child: ListView.builder(
                itemCount: playerMissionViewModel.playerMissions.length,
                itemBuilder: (context, index) {
                  final mission = playerMissionViewModel.playerMissions[index].mission;
                  return Card(
                    child: ListTile(
                      title: Text(mission.name),
                      subtitle: Text("Récompense : 💰 ${mission.rewardMoney} | ⚡ ${mission.rewardPower}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Gérer le lancement dans une autre étape
                        },
                        child: Text("Lancer"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}