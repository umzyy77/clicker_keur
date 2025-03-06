import 'difficulty_model.dart';

class MissionModel {
  final int id;
  final String name;
  final int rewardMoney;
  final int rewardPower;
  final DifficultyModel difficulty;

  MissionModel({
    required this.id,
    required this.name,
    required this.rewardMoney,
    required this.rewardPower,
    required this.difficulty,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) {
    return MissionModel(
      id: json['id'],
      name: json['name'],
      rewardMoney: json['reward_money'],
      rewardPower: json['reward_power'],
      difficulty: DifficultyModel.fromJson(json['difficulty']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "reward_money": rewardMoney,
      "reward_power": rewardPower,
      "difficulty": difficulty.toJson(),
    };
  }
}
