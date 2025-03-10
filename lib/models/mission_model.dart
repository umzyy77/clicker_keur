import 'difficulty_model.dart';

class MissionModel {
  final int idMission;
  final String name;
  final int rewardMoney;
  final int rewardPower;
  final DifficultyModel difficulty;

  MissionModel({
    required this.idMission,
    required this.name,
    required this.rewardMoney,
    required this.rewardPower,
    required this.difficulty,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    print("🔍 Conversion JSON → MissionModel : $json"); // DEBUG

    return MissionModel(
      idMission: json['id_mission'],
      name: json['name'],
      rewardMoney: json['reward_money'],
      rewardPower: json['reward_power'],
      difficulty: DifficultyModel.fromJson({
        "id_difficulty": json['id_difficulty'], // OK
        "label": json['difficulty_label'] ?? "Inconnu", // ⚠️ Label peut être absent
        "clicks_required": json['clicks_required'] ?? 0, // ⚠️ Peut être absent
      }),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id_mission": idMission,
      "name": name,
      "reward_money": rewardMoney,
      "reward_power": rewardPower,
      "difficulty": difficulty.toJson(),
    };
  }
}