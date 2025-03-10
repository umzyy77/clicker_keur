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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
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
            top: screenHeight * 0.15,
            left: screenWidth * 0.1,
            child: _buildMissionCard(playerMissionViewModel, missionViewModel, playerViewModel, 0),
          ),
          Positioned(
            bottom: screenHeight * 0.1,
            left: screenWidth * 0.5 - (screenWidth * 0.125),
            child: _buildMissionCard(playerMissionViewModel, missionViewModel, playerViewModel, 2),
          ),
          Positioned(
            top: screenHeight * 0.15,
            right: screenWidth * 0.1,
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

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 0.3 * MediaQuery.of(context).size.width,
          height: 0.2 * MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isLocked ? Colors.redAccent : Colors.greenAccent, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.5),
                blurRadius: 12,
                spreadRadius: 3,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 0.06 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/missionsbanner_$missionId.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
              Text(
                mission.name,
                style: TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Courier New'),
                textAlign: TextAlign.center,
              ),
              Text(
                "💰 ${mission.rewardMoney} | ⚡ ${mission.rewardPower}",
                style: TextStyle(color: Colors.white70, fontSize: 14, fontFamily: 'Courier New'),
              ),
              isLocked
                  ? Icon(Icons.lock, color: Colors.redAccent, size: 30)
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                child: Text("GO", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        if (_unlockedMissionId == missionId && _showGifAnimation)
          Positioned(
            child: Image.asset(
              "assets/unlock.gif",
              width: 100,
              height: 100,
            ),
          ),
      ],
    );
  }
}