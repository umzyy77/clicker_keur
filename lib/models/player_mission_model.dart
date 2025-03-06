import 'player_model.dart';
import 'mission_model.dart';
import 'status_model.dart';

class PlayerMissionModel {
  final PlayerModel player;
  final MissionModel mission;
  final StatusModel status;
  final int clicksDone;

  PlayerMissionModel({
    required this.player,
    required this.mission,
    required this.status,
    required this.clicksDone,
  });

  factory PlayerMissionModel.fromJson(Map<String, dynamic> json) {
    return PlayerMissionModel(
      player: PlayerModel.fromJson(json['player']),
      mission: MissionModel.fromJson(json['mission']),
      status: StatusModel.fromJson(json['status']),
      clicksDone: json['clicks_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "player": player.toJson(),
      "mission": mission.toJson(),
      "status": status.toJson(),
      "clicks_done": clicksDone,
    };
  }
}
