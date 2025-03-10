import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/mission_model.dart';
import 'package:untitled1/viewmodels/mission_viewmodel.dart';
import 'package:untitled1/views/mission_game_view.dart';
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
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    print("🔄 Chargement des missions...");

    await missionViewModel.loadMissions();
    print("📜 Missions récupérées (depuis API) : ${missionViewModel.missions.length}");

    await playerViewModel.loadPlayer();

    if (playerViewModel.player != null) {
      await playerMissionViewModel.loadPlayerMissions(playerViewModel.player!.id);
      print("📋 Missions du joueur : ${playerMissionViewModel.playerMissions.length}");
    }
  }


  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context);
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    if (playerViewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Hacking Clicker")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final player = playerViewModel.player;
    if (player == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Hacking Clicker")),
        body: Center(child: Text("Aucun joueur trouvé", style: TextStyle(fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Hacking Clicker")),
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
            SizedBox(height: 20),
            Text("📋 Missions disponibles :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            playerMissionViewModel.isLoading
                ? CircularProgressIndicator()
                : playerMissionViewModel.playerMissions.isEmpty
                ? Text("Aucune mission n'est disponible")
                : Expanded(
              child: ListView.builder(
                itemCount: playerMissionViewModel.playerMissions.length,
                itemBuilder: (context, index) {
                  final missionId = playerMissionViewModel.playerMissions[index].mission;
                  MissionModel? mission = missionViewModel.getMissionById(missionId);

                  print("🔍 Vérification : Mission $missionId trouvée ? ${mission != null}");

                  if (mission == null) {
                    print("⚠️ Mission $missionId introuvable !");
                    return SizedBox();
                  }

                  return Card(
                    child: ListTile(
                      title: Text(mission.name),
                      subtitle: Text("Récompense : 💰 ${mission.rewardMoney} | ⚡ ${mission.rewardPower}"),
                      trailing: ElevatedButton(
                        onPressed: () {
                          playerMissionViewModel.startMission(player.id, missionId);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MissionGameView(playerMission: playerMissionViewModel.playerMissions[index]),
                            ),
                          );
                        },
                        child: Text("${mission.idMission}"),
                      ),
                    ),
                  );
                }
,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
