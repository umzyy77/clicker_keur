import 'mission_model.dart';
import 'player_model.dart';
import 'status_model.dart';

class PlayerMissionModel {
  final MissionModel mission;
  final PlayerModel player;
  final StatusModel status;
  final int clicksDone;

  PlayerMissionModel({
    required this.mission,
    required this.player,
    required this.status,
    required this.clicksDone,
  });

  factory PlayerMissionModel.fromJson(Map<String, dynamic> json) {
    return PlayerMissionModel(
      mission: MissionModel.fromJson({
        "id_mission": json['id_mission'],
        "name": json['name'],
        "reward_money": json['reward_money'],
        "reward_power": json['reward_power'],
        "id_difficulty": json['id_difficulty'],
        "difficulty_label": json['difficulty_label'],
        "clicks_required": json['clicks_required'],
      }),
      player: PlayerModel.fromJson({
        "id_player": json['id_player'],
        "username": json['username'],
        "hacking_power": json['hacking_power'],
        "money": json['money'],
      }),
      status: StatusModel.fromJson({
        "id_status": json['id_status'],
        "label": json['status_label'],
      }),
      clicksDone: json['clicks_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mission": mission.toJson(),
      "player": player.toJson(),
      "status": status.toJson(),
      "clicks_done": clicksDone,
    };
  }
}
