import './api_service.dart';
import '../../models/player_upgrade_model.dart';

class UpgradeService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les améliorations possibles pour un joueur avec leur niveau actuel
  Future<List<PlayerUpgradeModel>> getAllUpgrades(int playerId) async {
    final response = await apiService.getRequest('/upgrades/$playerId');

    if (response is List) {
      return response.map((json) => PlayerUpgradeModel.fromJson(json)).toList();
    }
    return [];
  }

  /// 🔹 Récupère le bonus total de clics apporté par les améliorations achetées
  Future<int> getTotalClickBonus(int playerId) async {
    final response = await apiService.getRequest('/upgrades/$playerId/total_click_bonus');

    if (response is Map<String, dynamic> && response.containsKey('total_click_bonus')) {
      return response['total_click_bonus'] as int;
    }
    return 0;
  }

  /// 🔹 Achète une amélioration pour le joueur
  Future<PlayerUpgradeModel?> buyUpgrade(int playerId, int upgradeId) async {
    final response = await apiService.postRequest('/upgrades/$playerId/buy', {"upgrade_id": upgradeId});

    if (response != null && response is Map<String, dynamic>) {
      return PlayerUpgradeModel.fromJson(response);
    }
    return null;
  }
}