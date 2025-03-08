import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/player_mission_viewmodel.dart';
import '../models/player_mission_model.dart';

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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _incrementClicks() {
    Provider.of<PlayerMissionViewModel>(context, listen: false)
        .incrementClicks(widget.playerMission.mission.id);

    _animationController.forward(from: 0.0); // Déclenche l'animation d'éclair
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
              ],
            ),
          ),
          Positioned(
            bottom: 80,
            child: Column(
              children: [
                Icon(Icons.computer, size: 50, color: Colors.white),
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
            right: 50,
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.upgrade),
              tooltip: "Upgrades",
            ),
          ),
        ],
      ),
    );
  }
}