import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_mission_viewmodel.dart';
import '../viewmodels/player_upgrade_viewmodel.dart';
import '../models/player_mission_model.dart';
import '../models/upgrade_level_model.dart';

class MissionGameView extends StatefulWidget {
  final PlayerMissionModel playerMission;

  const MissionGameView({Key? key, required this.playerMission}) : super(key: key);

  @override
  _MissionGameViewState createState() => _MissionGameViewState();
}

class _MissionGameViewState extends State<MissionGameView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
  }

  void _incrementClicks() {
    Provider.of<PlayerMissionViewModel>(context, listen: false)
        .incrementClicks(widget.playerMission.mission.id);
    _animationController.forward(from: 0.0);
  }

  String getMissionImage(int missionId) {
    switch (missionId) {
      case 1:
        return 'assets/serveur.png';
      case 2:
        return 'assets/banque.png';
      case 3:
        return 'assets/gouvernement.png';
      default:
        return 'assets/default.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.playerMission.clicksDone / widget.playerMission.mission.difficulty.clicksRequired;

    return Scaffold(
      appBar: AppBar(title: Text("Mission: ${widget.playerMission.mission.name}")),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 75,
            child: Column(
              children: [
                Text("${widget.playerMission.clicksDone} / ${widget.playerMission.mission.difficulty.clicksRequired}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(value: progress, minHeight: 10),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            left: 50,
            child: Column(
              children: [
                Icon(Icons.person, size: 50, color: Colors.white),
                Text("Player"),
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Column(
              children: [
                Icon(Icons.computer, size: 50, color: Colors.white),
                Text("PC"),
              ],
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: _incrementClicks,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(getMissionImage(widget.playerMission.mission.id), width: 150),
                  FadeTransition(
                    opacity: _animation,
                    child: Icon(Icons.flash_on, color: Colors.blueAccent, size: 50),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Consumer<PlayerUpgradeViewModel>(
              builder: (context, viewModel, child) {
                List<UpgradeLevelModel>? playerUpgrades = viewModel.playerUpgrades;

                if (playerUpgrades!.isEmpty) {
                  return Center(
                    child: Text("Aucune amélioration disponible", style: TextStyle(color: Colors.white70)),
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: playerUpgrades.map((upgrade) {
                    return Column(
                      children: [
                        Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(upgrade.level > 0 ? 1.0 : 0.3),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Center(child: Text(upgrade.upgrade.name, textAlign: TextAlign.center)),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(3, (index) {
                            bool isUnlocked = (index + 1) <= upgrade.level;
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Container(
                                width: 20,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: isUnlocked ? Colors.black : Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

