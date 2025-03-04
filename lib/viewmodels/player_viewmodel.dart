import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../services/player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  PlayerModel? _player;
  bool _isLoading = false;

  PlayerModel get player => _player ?? PlayerModel(
    id: 0, pseudo: "Chargement...", totalExperience: 0, clickDamage: 1, currentEnemyLevel: 1,
  );

  bool get isLoading => _isLoading;

  // 🔹 Charger les infos du joueur
  Future<void> fetchPlayer(int playerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _player = await PlayerService.getPlayer(playerId);
    } catch (e) {
      print("Erreur : $e");
      _player = PlayerModel(id: 0, pseudo: "Erreur", totalExperience: 0, clickDamage: 1, currentEnemyLevel: 1);
    }

    _isLoading = false;
    notifyListeners();
  }

  // 🔹 Ajouter de l'XP au joueur
  Future<void> addExperience(int playerId) async {
    if (_player == null) return;

    try {
      await PlayerService.incrementPlayerXP(playerId);
      _player!.totalExperience += 10;
      notifyListeners();
    } catch (e) {
      print("Erreur : $e");
    }
  }

  // 🔹 Acheter une amélioration
  Future<void> buyEnhancement(int enhancementId) async {
    if (_player == null) return;

    try {
      await PlayerService.buyEnhancement(_player!.id, enhancementId);
      notifyListeners();
    } catch (e) {
      print("Erreur : $e");
    }
  }
}
