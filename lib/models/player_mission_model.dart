import 'player_model.dart';
import 'mission_model.dart';
import 'status_model.dart';

class PlayerMissionModel {
  final int mission;
  final int status;
  final int clicksDone;

  PlayerMissionModel({
    required this.mission,
    required this.status,
    required this.clicksDone,
  });

  factory PlayerMissionModel.fromJson(Map<String, dynamic> json) {
    return PlayerMissionModel(
      mission: json['id_mission'],
      status: json['id_status'],
      clicksDone: json['clicks_done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mission": mission,
      "status": status,
      "clicks_done": clicksDone,
    };
  }
}
