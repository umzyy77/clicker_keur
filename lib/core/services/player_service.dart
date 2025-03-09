import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './api_service.dart';
import '../../models/player_model.dart';

class PlayerService {
  final ApiService apiService = ApiService();
  static const String fileName = 'player.json';

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final corePath = '${directory.path}/core';
    await Directory(corePath).create(recursive: true);
    return File('$corePath/$fileName');
  }

  /// 🔹 Crée un nouveau joueur et stocke seulement son ID en local
  Future<PlayerModel?> createPlayer(String username) async {
    final response = await apiService.postRequest('/players', {"username": username});

    print("📩 [PlayerService] Réponse API: $response"); // DEBUG

    if (response != null && response.containsKey('player_id')) {
      int playerId = response['player_id'];

      // Sauvegarde uniquement l'ID
      await savePlayerId(playerId);

      // Charger immédiatement les infos complètes du joueur
      PlayerModel? player = await getPlayer(playerId);

      if (player != null) {
        print("✅ [PlayerService] Joueur créé et chargé avec ID: $playerId");
        return player;
      }
    }

    print("❌ [PlayerService] Erreur : Impossible de créer le joueur.");
    return null;
  }

  /// 🔹 Charger le joueur depuis l'ID stocké localement
  Future<PlayerModel?> loadStoredPlayer() async {
    int? playerId = await loadStoredPlayerId();
    if (playerId == null) return null;

    return await getPlayer(playerId);
  }

  /// 🔹 Vérifie si un joueur est stocké localement
  Future<bool> isPlayerStored() async {
    final id = await loadStoredPlayerId();
    return id != null;
  }

  /// 🔹 Récupère le joueur depuis l'API avec son ID
  Future<PlayerModel?> getPlayer(int playerId) async {
    final response = await apiService.getRequest('/players/$playerId');

    if (response != null && response is Map<String, dynamic>) {
      return PlayerModel.fromJson(response);
    }
    return null;
  }

  /// 🔹 Supprime un joueur via API et efface son ID local
  Future<bool> deletePlayer(int playerId) async {
    bool success = await apiService.deleteRequest('/players/$playerId');
    if (success) {
      await _removeStoredPlayerId();
    }
    return success;
  }

  /// 🔹 Sauvegarde uniquement l'ID du joueur dans le JSON local
  Future<void> savePlayerId(int playerId) async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode({"id_player": playerId}));
    print("💾 [PlayerService] ID Joueur sauvegardé : $playerId");
  }

  /// 🔹 Charge l'ID joueur depuis le JSON local
  Future<int?> loadStoredPlayerId() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        Map<String, dynamic> json = jsonDecode(contents);
        print("🔍 [PlayerService] ID joueur local : ${json['id_player']}");
        return json['id_player'];
      }
    } catch (e) {
      print("⚠️ Erreur lecture ID joueur : $e");
    }
    return null;
  }

  /// 🔹 Supprime le JSON contenant l'ID du joueur
  Future<void> _removeStoredPlayerId() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
      print("🗑 [PlayerService] ID joueur supprimé du stockage local.");
    }
  }
}
