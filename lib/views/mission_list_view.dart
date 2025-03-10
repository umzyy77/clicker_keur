import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/mission_model.dart';
import 'package:untitled1/viewmodels/mission_viewmodel.dart';
import 'package:untitled1/views/mission_game_view.dart';
import '../viewmodels/player_viewmodel.dart';
import '../viewmodels/player_mission_viewmodel.dart';

class MissionsListView extends StatefulWidget {
  @override
  _MissionsListViewState createState() => _MissionsListViewState();
}

class _MissionsListViewState extends State<MissionsListView> {
  bool _isCheckingForUnlockedMission = false;
  bool _showGifAnimation = false; // ✅ Variable pour afficher le GIF
  int? _unlockedMissionId;

  @override
  void initState() {
    super.initState();
    _loadPlayerAndMissions();
  }

  Future<void> _loadPlayerAndMissions() async {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context, listen: false);
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    await missionViewModel.loadMissions();
    await playerViewModel.loadPlayer();

    if (playerViewModel.player != null) {
      await playerMissionViewModel.loadPlayerMissions(playerViewModel.player!.id);
      _checkForUnlockedMission(playerViewModel.player!.id);
    }
  }

  Future<void> _checkForUnlockedMission(int playerId) async {
    if (_isCheckingForUnlockedMission) return;
    _isCheckingForUnlockedMission = true;

    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context, listen: false);
    int? unlockedMissionId = await playerMissionViewModel.checkNewlyUnlockedMission(playerId);

    if (unlockedMissionId != null && mounted) {
      setState(() {
        _unlockedMissionId = unlockedMissionId;
        _showGifAnimation = true; // ✅ Active l'affichage du GIF
      });

      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showGifAnimation = false; // ✅ Cache le GIF après 2 secondes
          });
        }
      });
    }
    _isCheckingForUnlockedMission = false;
  }

  void _showUnlockedAnimation(int missionId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("🎉 Mission Débloquée !"),
        content: Text("La mission #$missionId a été débloquée !"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context);
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    if (playerViewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("📋 Missions disponibles")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final player = playerViewModel.player;
    if (player == null) {
      return Scaffold(
        appBar: AppBar(title: Text("📋 Missions disponibles")),
        body: Center(child: Text("Aucun joueur trouvé", style: TextStyle(fontSize: 18))),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("📋 Missions disponibles")),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                        if (mission == null) {
                          return SizedBox();
                        }

                        return Card(
                          child: ListTile(
                            title: Text(mission.name),
                            subtitle: Text("Récompense : 💰 ${mission.rewardMoney} | ⚡ ${mission.rewardPower}"),
                            trailing: playerMissionViewModel.playerMissions[index].status == 1
                                ? Text("🔒 Mission verrouillée", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                                : ElevatedButton(
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
                      }),
                ),
              ],
            ),
          ),

          // ✅ Affichage du GIF lorsqu'une mission est débloquée
          if (_showGifAnimation)
            Center(
              child: Image.asset(
                "assets/unlock.gif", // ✅ Ton GIF ici
                width: 200,
                height: 200,
              ),
            ),
        ],
      ),
    );
  }
}
