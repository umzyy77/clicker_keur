import 'package:shared_preferences/shared_preferences.dart';
import './api_service.dart';
import '../../models/player_model.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  /// 🔹 Crée un nouveau joueur et stocke son ID localement
  Future<PlayerModel?> createPlayer(String username) async {
    final response = await apiService.postRequest('/players', {"username": username});

    if (response != null && response.containsKey('id_player')) { // ✅ Vérifie si `id_player` est bien retourné
      PlayerModel player = PlayerModel.fromJson(response); // ✅ Utilisation du `fromJson` directement

      // 📌 Stocker l'ID du joueur localement
      await _savePlayerId(player.idPlayer);

      return player;
    }
    return null;
  }

  /// 🔹 Vérifie si un joueur est stocké localement et existe sur le serveur
  Future<bool> isPlayerStored() async {
    int? playerId = await getStoredPlayerId();
    if (playerId == null) return false;

    PlayerModel? player = await getPlayer(playerId);
    return player != null; // Si on récupère bien le joueur, il existe
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
      await _removePlayerId(); // Effacer l'ID localement
    }
    return success;
  }

  /// 🔹 Stocke l’ID du joueur dans `SharedPreferences`
  Future<void> _savePlayerId(int playerId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('player_id', playerId);
  }

  /// 🔹 Récupère l’ID du joueur stocké localement
  Future<int?> getStoredPlayerId() async {
    final prefs = await SharedPreferences.getInstance();
    int? playerId = prefs.getInt('player_id');
    print("🔍 ID stocké localement: $playerId"); // DEBUG
    return playerId;
  }

  /// 🔹 Supprime l’ID du joueur stocké
  Future<void> _removePlayerId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('player_id');
  }
}
