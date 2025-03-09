import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import './api_service.dart';
import '../../models/player_model.dart';
import 'package:path_provider/path_provider.dart';

class PlayerService {
  final ApiService apiService = ApiService();
  static const String fileName = 'player.json';

  /// 📌 Récupère le chemin correct du fichier JSON
  Future<File> get _localFile async {
    // Création d'un dossier 'core' dans le répertoire temporaire de l'application
    final directory = await getApplicationDocumentsDirectory();
    final corePath = '${directory.path}/core';
    await Directory(corePath).create(recursive: true);
    return File('$corePath/$fileName');
  }

  /// 🔹 Crée un nouveau joueur et le stocke en local
  Future<PlayerModel?> createPlayer(String username) async {
    final response = await apiService.postRequest('/players', {"username": username});

    print("📩 [PlayerService] Réponse API: $response"); // DEBUG

    if (response != null && response is Map<String, dynamic> && response.containsKey('player_id')) {
      PlayerModel player = PlayerModel.fromJson({
        "id_player": response['player_id'],
        "username": username,
        "hacking_power": response['hacking_power'] ?? 1,
        "money": response['money'] ?? 0
      });

      await savePlayerData(player); // ✅ Sauvegarde du joueur en JSON localement

      print("✅ [PlayerService] Joueur créé avec ID: ${player.idPlayer}");
      return player;
    }

    print("❌ [PlayerService] Erreur: Réponse invalide ou ID manquant.");
    return null;
  }

  /// 🔹 Charge le joueur stocké en local
  Future<PlayerModel?> loadStoredPlayer() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        String contents = await file.readAsString();
        Map<String, dynamic> json = jsonDecode(contents);
        print("🔍 [PlayerService] Chargement joueur depuis JSON: $json");
        return PlayerModel.fromJson(json);
      }
    } catch (e) {
      print("⚠️ Erreur lors du chargement du fichier JSON: $e");
    }
    return null;
  }

  /// 🔹 Vérifie si un joueur est stocké en local
  Future<bool> isPlayerStored() async {
    final file = await _localFile;
    return await file.exists();
  }

  /// 🔹 Récupère un joueur depuis l'API et met à jour le fichier JSON
  Future<PlayerModel?> getPlayer(int playerId) async {
    final response = await apiService.getRequest('/players/$playerId');

    if (response != null && response is Map<String, dynamic>) {
      PlayerModel player = PlayerModel.fromJson(response);
      await savePlayerData(player); // ✅ Mettre à jour le fichier JSON
      return player;
    }
    return null;
  }

  /// 🔹 Supprime un joueur et efface ses données locales
  Future<bool> deletePlayer(int playerId) async {
    bool success = await apiService.deleteRequest('/players/$playerId');
    if (success) {
      await _removePlayerData();
    }
    return success;
  }

  /// 🔹 Sauvegarde le joueur dans un fichier JSON
  Future<void> savePlayerData(PlayerModel player) async {
    try {
      final file = await _localFile;
      await file.writeAsString(jsonEncode(player.toJson()));
      print("💾 [PlayerService] Joueur sauvegardé en JSON : ${player.toJson()}");
    } catch (e) {
      print("⚠️ Erreur lors de l'écriture du fichier JSON: $e");
    }
  }

  /// 🔹 Supprime le fichier JSON contenant le joueur
  Future<void> _removePlayerData() async {
    final file = await _localFile;
    if (await file.exists()) {
      await file.delete();
      print("🗑 [PlayerService] Joueur supprimé du stockage local.");
    }
  }
}