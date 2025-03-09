import 'difficulty_model.dart';

class MissionModel {
  final int id;
  final String name;
  final int rewardMoney;
  final int rewardPower;
  final int difficulty;

  MissionModel({
    required this.id,
    required this.name,
    required this.rewardMoney,
    required this.rewardPower,
    required this.difficulty,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id_mission'],
      name: json['name'],
      rewardMoney: json['reward_money'],
      rewardPower: json['reward_power'],
      difficulty: json['id_difficulty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_mission": id,
      "name": name,
      "reward_money": rewardMoney,
      "reward_power": rewardPower,
      "id_difficulty": difficulty,
    };
  }
}
