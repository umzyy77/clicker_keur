class PlayerUpgradeModel {
  final int idUpgrade;
  final String name;
  final int level;
  final int cost;
  final int boostValue;
  final bool purchased;

  PlayerUpgradeModel({
    required this.idUpgrade,
    required this.name,
    required this.level,
    required this.cost,
    required this.boostValue,
    required this.purchased,
  });

  factory PlayerUpgradeModel.fromJson(Map<String, dynamic> json) {
    return PlayerUpgradeModel(
      idUpgrade: json['id_upgrade'] as int,
      name: json['name'] as String,
      level: json['level'] as int,
      cost: json['cost'] as int,
      boostValue: json['boost_value'] as int,
      purchased: (json['purchased'] as int) == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_upgrade": idUpgrade,
      "name": name,
      "level": level,
      "cost": cost,
      "boost_value": boostValue,
      "purchased": purchased ? 1 : 0,
    };
  }

  PlayerUpgradeModel get upgradeLevel => this;
}
