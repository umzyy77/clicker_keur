import './api_service.dart';
import '../../models/mission_model.dart';

class MissionService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les missions disponibles du jeu mais pas du joueur
  Future<List<MissionModel>> getAllMissions() async {
    final response = await apiService.getRequest('/missions');

    if (response != null && response is List) {
      print("📜 Réponse brute API (missions) : $response");
      return response.map((json) => MissionModel.fromJson(json)).toList();
    }

    print("🚨 Aucune mission récupérée depuis l'API !");
    return [];
  }


  /// 🔹 Récupère une mission spécifique par son ID
  Future<MissionModel?> getMission(int missionId) async {
    final response = await apiService.getRequest('/missions/$missionId');

    if (response != null) {
      return MissionModel.fromJson(response);
    }
    return null;
  }

  /// 🔹 Récupère l'objectif d'une mission (nombre de clics requis)
  Future<int?> getMissionObjective(int missionId) async {
    final response = await apiService.getRequest('/missions/$missionId/objective');

    if (response != null) {
      return response['clicks_required'];
    }
    return null;
  }
}