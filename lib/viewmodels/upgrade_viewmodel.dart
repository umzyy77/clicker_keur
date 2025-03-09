import 'package:flutter/material.dart';
import '../core/services/upgrade_service.dart';
import '../models/upgrade_level_model.dart';

class UpgradeViewModel with ChangeNotifier {
  final UpgradeService _upgradeService = UpgradeService();
  List<UpgradeLevelModel> _upgrades = [];
  bool _isLoading = false;

  List<UpgradeLevelModel> get upgrades => _upgrades;
  bool get isLoading => _isLoading;

  Future<void> fetchUpgrades(int playerId) async {
    _isLoading = true;
    notifyListeners();
    _upgrades = (await _upgradeService.getAllUpgrades(playerId)).cast<UpgradeLevelModel>();
    _isLoading = false;
    notifyListeners();
  }
//
  Future<void> buyUpgrade(int playerId, int upgradeId) async {
    bool success = await _upgradeService.buyUpgrade(playerId, upgradeId);
    if (success) {
      await fetchUpgrades(playerId);
    }
  }
}