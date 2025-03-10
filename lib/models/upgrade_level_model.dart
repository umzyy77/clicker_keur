import 'upgrade_model.dart';

class UpgradeLevelModel {
  final int idLevel;
  final int level;
  final int cost;
  final int boostValue;
  final UpgradeModel upgrade;

  UpgradeLevelModel({
    required this.idLevel,
    required this.level,
    required this.cost,
    required this.boostValue,
    required this.upgrade,
  });

  factory UpgradeLevelModel.fromJson(Map<String, dynamic> json) {
    return UpgradeLevelModel(
      idLevel: json['id_level'],
      level: json['level'],
      cost: json['cost'],
      boostValue: json['boost_value'],
      upgrade: UpgradeModel.fromJson({
        "id_upgrade": json['id_upgrade'],
        "name": json['name'],
      }),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_level": idLevel,
      "level": level,
      "cost": cost,
      "boost_value": boostValue,
      "upgrade": upgrade.toJson(),
    };
  }
}