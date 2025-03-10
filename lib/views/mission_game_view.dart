import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/widgets/mission_ennemy.dart';
import '../viewmodels/mission_viewmodel.dart';
import '../viewmodels/player_mission_viewmodel.dart';
import '../viewmodels/player_viewmodel.dart';
import '../models/player_mission_model.dart';
import '../widgets/mission_progress_bar.dart';
import '../widgets/mission_click_button.dart';
import '../widgets/mission_completion_dialog.dart';

class MissionGameView extends StatefulWidget {
  final PlayerMissionModel playerMission;

  const MissionGameView({Key? key, required this.playerMission})
      : super(key: key);

  @override
  _MissionGameViewState createState() => _MissionGameViewState();
}

class _MissionGameViewState extends State<MissionGameView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int? clicksRequired;
  late PlayerMissionModel _currentMission;
  bool _isMissionComplete = false; // 🔹 Bloque les clics après complétion

  @override
  void initState() {
    super.initState();
    _currentMission = widget.playerMission;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);

    _loadClicksRequired();
  }

  Future<void> _loadClicksRequired() async {
    final missionViewModel =
        Provider.of<MissionViewModel>(context, listen: false);
    int? requiredClicks = await missionViewModel
        .getMissionClicksRequired(_currentMission.mission);

    if (requiredClicks != null) {
      setState(() {
        clicksRequired = requiredClicks;
      });
    }
  }

  Future<void> _incrementClicks() async {
    if (_isMissionComplete)
      return; // 🔹 Bloquer les clics si la mission est terminée

    final playerViewModel =
        Provider.of<PlayerViewModel>(context, listen: false);
    final playerMissionViewModel =
        Provider.of<PlayerMissionViewModel>(context, listen: false);

    bool success = await playerMissionViewModel.incrementMissionClicks(
      playerViewModel.player!.id,
      _currentMission.mission,
    );

    if (!success) {
      setState(() {
        _isMissionComplete = true;
      });
      showMissionCompletionDialog(context, _currentMission.mission);
      return;
    }

    // 🔹 Rafraîchir les missions après un clic
    await playerMissionViewModel.loadPlayerMissions(playerViewModel.player!.id);

    setState(() {
      final updatedMission = playerMissionViewModel.playerMissions.firstWhere(
        (mission) => mission.mission == _currentMission.mission,
        orElse: () => _currentMission,
      );

      if (updatedMission.mission != _currentMission.mission ||
          updatedMission.clicksDone != _currentMission.clicksDone) {
        _currentMission = updatedMission;
      }

      if (_currentMission.clicksDone >= (clicksRequired ?? 0)) {
        _isMissionComplete = true;
        showMissionCompletionDialog(context, _currentMission.mission);
      }
    });

    _animationController.forward(from: 0.0);
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
          MissionEnnemy(missionId: _currentMission.mission),
          MissionClickButton(
            onTap: _isMissionComplete ? () {} : () => _incrementClicks(),
          ),
        ],
      ),
    );
  }
}
