import 'package:shared_preferences/shared_preferences.dart';
import './api_service.dart';
import '../../models/player_mission_model.dart';

class PlayerMissionService {
  final ApiService apiService = ApiService();

  /// 🔹 Récupère toutes les missions d'un joueur pour le menu ou autre
  Future<List<PlayerMissionModel>> getMissionsForPlayer(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId');

    if (response != null && response is List) {
      return response.map((json) => PlayerMissionModel.fromJson(json)).toList();
    }
    return [];
  }

  /// 🔹 Récupère la première mission déverrouillée d’un joueur (methode pas trop utile)
  Future<int?> getFirstUnlockedMission(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId/first_unlocked');

    if (response != null && response.containsKey('first_unlocked_mission')) {
      return response['first_unlocked_mission'];
    }
    return null;
  }

  /// 🔹 Démarre une mission pour le joueur et stocke localement son ID + le status de la mission deviens "in_progress"
  Future<bool> startMission(int playerId, int missionId) async {
    final response = await apiService.postRequest('/player_missions/$playerId/start', {"mission_id": missionId});

    if (response != null) {
      await _saveCurrentMissionId(missionId);
      return true;
    }
    return false;
  }

  /// 🔹 Vérifie si une nouvelle mission a été débloquée pour l'animation du cadenas debloqué au menu ou autre animation
  Future<int?> checkNewlyUnlockedMission(int playerId) async {
    final response = await apiService.getRequest('/player_missions/$playerId/newly_unlocked');

    if (response != null && response.containsKey('id_mission')) {
      return response['id_mission'];
    }
    return null;
  }

  /// 🔹 Incrémente les clics d’une mission et sa logique de gameloop à envoie à l’API
  Future<bool> incrementClicks(int playerId, int missionId) async {
    final response = await apiService.patchRequest(
        '/player_missions/$playerId/increment',
        {"mission_id": missionId}
    );

    print("📡 Réponse API (incrémentation) : $response");

    if (response == null) {
      print("❌ Erreur : Aucune réponse de l'API !");
      return false;
    }

    return response;  // Si l'API retourne `true/false`, on l'utilise directement.
  }


  /// 🔹 Stocke localement l'ID de la mission en cours
  Future<void> _saveCurrentMissionId(int missionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('current_mission_id', missionId);
  }

  /// 🔹 Récupère l’ID de la mission en cours (si existant)
  Future<int?> getStoredMissionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('current_mission_id');
  }

  /// 🔹 Supprime l’ID de la mission en cours (si terminée ou annulée)
  Future<void> clearCurrentMissionId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_mission_id');
  }
}
