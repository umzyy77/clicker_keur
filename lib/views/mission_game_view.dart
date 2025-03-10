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

  const MissionGameView({super.key, required this.playerMission});

  @override
  _MissionGameViewState createState() => _MissionGameViewState();
}

class _MissionGameViewState extends State<MissionGameView>
    with SingleTickerProviderStateMixin {
  int? clicksRequired;
  late PlayerMissionModel _currentMission;

  @override
  void initState() {
    super.initState();
    _currentMission = widget.playerMission;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MissionViewModel>(context, listen: false).loadMission(_currentMission.mission);
    });
  }

  @override
  Widget build(BuildContext context) {
    final missionViewModel = Provider.of<MissionViewModel>(context);
    final playerMissionViewModel = Provider.of<PlayerMissionViewModel>(context);
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);

    int? clicksRequired = missionViewModel.missionObjective;
    int clicksDone = playerMissionViewModel.playerMissions
        .firstWhere((m) => m.mission == _currentMission.mission, orElse: () => _currentMission)
        .clicksDone;

    return Scaffold(
      appBar: AppBar(title: Text("Mission en cours")),
      body: Stack(
        children: [
          MissionEnnemy(missionId: _currentMission.mission),
          MissionProgressBar(
            clicksDone: clicksDone,
            clicksRequired: clicksRequired,
          ),
          Text("$clicksDone"),
          MissionClickButton(
            onTap: clicksDone >= (clicksRequired ?? 0)
                ? () => showMissionCompletionDialog(context, _currentMission.mission)
                : () => playerMissionViewModel.incrementMissionClicks(playerViewModel.player!.id, _currentMission.mission),
          ),
        ],
      ),
    );
  }
}
