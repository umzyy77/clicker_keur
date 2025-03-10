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
    MissionViewModel missionViewModel = Provider.of<MissionViewModel>(context, listen: false);

    missionViewModel.loadMission(_currentMission.mission);
    clicksRequired = missionViewModel.missionObjective;

    print(clicksRequired);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mission en cours")),
      body: Stack(
        children: [
          MissionEnnemy(missionId: _currentMission.mission),
          MissionProgressBar(
            clicksDone: _currentMission.clicksDone,
            clicksRequired: clicksRequired,
          ),
          Text("${_currentMission.clicksDone}"),
          MissionClickButton(
            onTap: _currentMission.clicksDone >= (clicksRequired ?? 0)
                ? () => showMissionCompletionDialog(
                    context, _currentMission.mission)
                : () => Provider.of<PlayerMissionViewModel>(context, listen: false)
                .incrementMissionClicks(
                Provider.of<PlayerViewModel>(context, listen: false)
                    .player!.id, _currentMission.mission)
          ),
        ],
      ),
    );
  }
}
