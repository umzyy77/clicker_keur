import 'player_model.dart';
import 'upgrade_level_model.dart';

class PlayerUpgradeModel {
  final PlayerModel player;
  final UpgradeLevelModel upgradeLevel;

  PlayerUpgradeModel({required this.player, required this.upgradeLevel});

  factory PlayerUpgradeModel.fromJson(Map<String, dynamic> json) {
    return PlayerUpgradeModel(
      player: PlayerModel.fromJson(json['player']),
      upgradeLevel: UpgradeLevelModel.fromJson(json['upgrade_level']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "player": player.toJson(),
      "upgrade_level": upgradeLevel.toJson(),
    };
  }
}
