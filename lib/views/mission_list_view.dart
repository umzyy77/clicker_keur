import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/models/mission_model.dart';
import 'package:untitled1/viewmodels/mission_viewmodel.dart';
import 'package:untitled1/views/mission_game_view.dart';
import 'package:untitled1/views/home_view.dart';
import '../viewmodels/player_viewmodel.dart';
import '../viewmodels/player_mission_viewmodel.dart';

class MissionsListView extends StatefulWidget {
  @override
  _MissionsListViewState createState() => _MissionsListViewState();
}

class _MissionsListViewState extends State<MissionsListView> {
  bool _isCheckingForUnlockedMission = false;
  bool _showGifAnimation = false;
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
        _showGifAnimation = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showGifAnimation = false;
          });
        }
      });
    }
    _isCheckingForUnlockedMission = false;
  }

  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context);
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_hacker1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.greenAccent, size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: _buildMissionCard(playerMissionViewModel, missionViewModel, playerViewModel, 0),
          ),
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 75,
            child: _buildMissionCard(playerMissionViewModel, missionViewModel, playerViewModel, 2),
          ),
          Positioned(
            top: 100,
            right: 20,
            child: _buildMissionCard(playerMissionViewModel, missionViewModel, playerViewModel, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionCard(PlayerMissionViewModel playerMissionViewModel, MissionViewModel missionViewModel, PlayerViewModel playerViewModel, int index) {
    if (index >= playerMissionViewModel.playerMissions.length) return SizedBox();

    final missionId = playerMissionViewModel.playerMissions[index].mission;
    MissionModel? mission = missionViewModel.getMissionById(missionId);

    if (mission == null) return SizedBox();

    bool isLocked = playerMissionViewModel.playerMissions[index].status == 1;

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: isLocked ? Colors.redAccent : Colors.greenAccent, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/missionsbanner_$missionId.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
          ),
          Text(
            mission.name,
            style: TextStyle(color: Colors.greenAccent, fontSize: 14, fontFamily: 'Courier New'),
            textAlign: TextAlign.center,
          ),
          Text(
            "💰 ${mission.rewardMoney} | ⚡ ${mission.rewardPower}",
            style: TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Courier New'),
          ),
          isLocked
              ? Icon(Icons.lock, color: Colors.redAccent, size: 30)
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              playerMissionViewModel.startMission(playerViewModel.player!.id, missionId);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MissionGameView(
                    playerMission: playerMissionViewModel.playerMissions[index],
                  ),
                ),
              );
            },
            child: Text("GO"),
          ),
        ],
      ),
    );
  }
}
