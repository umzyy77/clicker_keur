import '../../models/upgrade_full_model.dart';
import './api_service.dart';

class UpgradeService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les améliorations disponibles et les convertit en objets `PlayerUpgradeModel`
  Future<List<PlayerUpgradeModel>> getAllUpgrades(int playerId) async {
    final response = await apiService.getRequest('/upgrades/$playerId');

    if (response is List) {
      print("📜 Réponse API : $response");

      return response.map((json) {
        return PlayerUpgradeModel.fromJson(json);
      }).toList();
    }

    print("❌ Erreur: réponse API inattendue : $response");
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
  Future<bool> buyUpgrade(int playerId, int upgradeId) async {
    final response = await apiService.postRequest('/upgrades/$playerId/buy', {"upgrade_id": upgradeId});

    if (response != null && response is Map<String, dynamic> && response.containsKey('message')) {
      print("✅ Amélioration achetée avec succès !");
      return true;
    }
    print("❌ Échec de l'achat de l'amélioration.");
    return false;
  }
}
