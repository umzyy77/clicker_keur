import './api_service.dart';
import '../../models/upgrade_model.dart';

class UpgradeService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les améliorations disponibles pour un joueur
  Future<List<UpgradeModel>> getAllUpgrades(int playerId) async {
    final response = await apiService.getRequest('/upgrades/$playerId');

    if (response != null && response is List) {
      return response.map((json) => UpgradeModel.fromJson(json)).toList();
    }
    return [];
  }

  /// 🔹 Récupère le bonus total de clics apporté par les améliorations achetées
  Future<int> getTotalClickBonus(int playerId) async {
    final response = await apiService.getRequest('/upgrades/$playerId/total_click_bonus');

    if (response != null && response.containsKey('total_click_bonus')) {
      return response['total_click_bonus'];
    }
    return 0;
  }

  /// 🔹 Achète une amélioration pour le joueur
  Future<bool> buyUpgrade(int playerId, int upgradeId) async {
    final response = await apiService.postRequest('/upgrades/$playerId/buy', {"upgrade_id": upgradeId});

    return response != null;
  }
}
