import 'player_model.dart';
import 'upgrade_level_model.dart';

class PlayerUpgradeModel {
  final PlayerModel player;
  final UpgradeLevelModel upgradeLevel;
  final bool purchased;

  PlayerUpgradeModel({
    required this.player,
    required this.upgradeLevel,
    required this.purchased,
  });

  factory PlayerUpgradeModel.fromJson(Map<String, dynamic> json) {
    return PlayerUpgradeModel(
      player: PlayerModel.fromJson({
        "id_player": json['id_player'],
        "money": json['money'],
      }),
      upgradeLevel: UpgradeLevelModel.fromJson(json['upgrade_level']),
      purchased: json['purchased'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "player": player.toJson(),
      "upgrade_level": upgradeLevel.toJson(),
      "purchased": purchased ? 1 : 0,
    };
  }
}