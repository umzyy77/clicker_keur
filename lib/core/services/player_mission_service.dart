import './api_service.dart';
import '../../models/player_mission_model.dart';

class PlayerMissionService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les missions d'un joueur
  Future<List<PlayerMissionModel>> getMissionsForPlayer(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId');

    if (response is List) {
      print("📋 Missions du joueur (réponse API) : $response"); // 🔍 DEBUG
      return response.map((json) => PlayerMissionModel.fromJson(json)).toList();
    }

    print("❌ Aucune mission trouvée pour le joueur $playerId");
    return [];
  }


  /// 🔹 Récupère la première mission déverrouillée d’un joueur
  Future<int?> getFirstUnlockedMission(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId/first_unlocked');

    if (response is Map<String, dynamic> && response.containsKey('first_unlocked_mission')) {
      return response['first_unlocked_mission'];
    }
    return null;
  }

  /// 🔹 Démarre une mission pour le joueur
  Future<bool> startMission(int playerId, int missionId) async {
    final response = await apiService.postRequest('/player_missions/$playerId/start', {"mission_id": missionId});

    return response is Map<String, dynamic> && response.containsKey('message');
  }

  /// 🔹 Vérifie si une nouvelle mission a été débloquée
  Future<int?> checkNewlyUnlockedMission(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId/newly_unlocked');

    if (response is Map<String, dynamic> && response.containsKey('id_mission')) {
      return response['id_mission'];
    }
    return null;
  }

  /// 🔹 Incrémente les clics d’une mission
  Future<bool> incrementClicks(int playerId, int missionId) async {
    return await apiService.patchRequest(
      '/player_missions/$playerId/increment',
      {"mission_id": missionId},
    );
  }
}