import 'upgrade_model.dart';

class UpgradeLevelModel {
  final int id;
  final int level;
  final int cost;
  final int boostValue;
  final UpgradeModel upgrade;

  UpgradeLevelModel({
    required this.id,
    required this.level,
    required this.cost,
    required this.boostValue,
    required this.upgrade,
  });

  factory UpgradeLevelModel.fromJson(Map<String, dynamic> json) {
    return UpgradeLevelModel(
      id: json['id'],
      level: json['level'],
      cost: json['cost'],
      boostValue: json['boost_value'],
      upgrade: UpgradeModel.fromJson(json['upgrade']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "level": level,
      "cost": cost,
      "boost_value": boostValue,
      "upgrade": upgrade.toJson(),
    };
  }
}
