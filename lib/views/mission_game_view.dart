import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/mission_viewmodel.dart';
import '../viewmodels/player_mission_viewmodel.dart';
import '../viewmodels/player_viewmodel.dart';
import '../models/player_mission_model.dart';
import '../widgets/mission_progress_bar.dart';
import '../widgets/mission_click_button.dart';
import '../widgets/mission_completion_dialog.dart';


class MissionGameView extends StatefulWidget {
  final PlayerMissionModel playerMission;

  const MissionGameView({Key? key, required this.playerMission}) : super(key: key);

  @override
  _MissionGameViewState createState() => _MissionGameViewState();
}

class _MissionGameViewState extends State<MissionGameView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? clicksRequired;
  late PlayerMissionModel _currentMission;

  @override
  void initState() {
    super.initState();
    _currentMission = widget.playerMission;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _loadClicksRequired();
  }

  Future<void> _loadClicksRequired() async {
    final missionViewModel = Provider.of<MissionViewModel>(context, listen: false);
    int? requiredClicks = await missionViewModel.getMissionClicksRequired(_currentMission.mission);

    if (requiredClicks != null) {
      setState(() {
        clicksRequired = requiredClicks;
      });
    }
  }

  Future<void> _incrementClicks() async {
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context, listen: false);

    bool success = await playerMissionViewModel.incrementMissionClicks(
      playerViewModel.player!.id,
      _currentMission.mission,
    );

    if (success) {
      await playerMissionViewModel.loadPlayerMissions(playerViewModel.player!.id);

      setState(() {
        _currentMission = playerMissionViewModel.playerMissions.firstWhere(
              (mission) => mission.mission == _currentMission.mission,
          orElse: () => _currentMission,
        );
      });

      _animationController.forward(from: 0.0);

      if (_currentMission.clicksDone >= (clicksRequired ?? 0)) {
        showMissionCompletionDialog(context, _currentMission.mission);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mission en cours")),
      body: Stack(
        children: [
          MissionProgressBar(
            clicksDone: _currentMission.clicksDone,
            clicksRequired: clicksRequired,
          ),
          MissionClickButton(
            onTap: _incrementClicks,
            animation: _animation,
            missionId: _currentMission.mission,
          ),
        ],
      ),
    );
  }
}
