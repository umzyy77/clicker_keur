import 'player_model.dart';
import 'mission_model.dart';
import 'status_model.dart';

class PlayerMissionModel {
  final int player;
  final int mission;
  final int status;
  final int clicksDone;

  PlayerMissionModel({
    required this.player,
    required this.mission,
    required this.status,
    required this.clicksDone,
  });

  factory PlayerMissionModel.fromJson(Map<String, dynamic> json) {
    return PlayerMissionModel(
      player: json['id_player'],
      mission: json['id_mission'],
      status: json['id_status'],
      clicksDone: json['clicks_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "player": player,
      "mission": mission,
      "status": status,
      "clicks_done": clicksDone,
    };
  }
}
