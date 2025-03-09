import 'package:shared_preferences/shared_preferences.dart';
import './api_service.dart';
import '../../models/player_model.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  /// 🔹 Crée un nouveau joueur et stocke son ID localement
  Future<PlayerModel?> createPlayer(String username) async {
    final response = await apiService.postRequest('/players', {"username": username});

    if (response != null && response.containsKey('player_id')) {
      PlayerModel player = PlayerModel(
        id: response['player_id'],
        username: username,
        hackingPower: 1,
        money: 0,
      );

      // 📌 Stocker l'ID du joueur
      await _savePlayerId(player.id);

      return player;
    }
    return null;
  }

  /// 🔹 Récupère un joueur par son ID
  Future<PlayerModel?> getPlayer(int playerId) async {
    final response = await apiService.getRequest('/players/$playerId');

    if (response != null) {
      return PlayerModel.fromJson(response);
    }
    return null;
  }

  /// 🔹 Supprime un joueur et efface son ID localement
  Future<bool> deletePlayer(int playerId) async {
    bool success = await apiService.deleteRequest('/players/$playerId');
    if (success) {
      await _removePlayerId();  // Efface l'ID localement
    }
    return success;
  }

  /// 🔹 Stocke l’ID du joueur dans `SharedPreferences`
  Future<void> _savePlayerId(int playerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('player_id', playerId);
  }

  /// 🔹 Récupère l’ID du joueur stocké
  Future<int?> getStoredPlayerId() async {
    final prefs = await SharedPreferences.getInstance();
    int? playerId = prefs.getInt('player_id');
    return playerId;
  }


  /// 🔹 Supprime l’ID du joueur stocké
  Future<void> _removePlayerId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('player_id');
  }
}
