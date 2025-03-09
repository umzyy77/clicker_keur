import 'package:flutter/material.dart';
import '../models/player_model.dart';
import '../core/services/player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  final PlayerService _playerService = PlayerService();
  PlayerModel? _player;
  bool _isLoading = false;
  String? _errorMessage;

  PlayerModel? get player => _player;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Récupère un joueur depuis l'ID stocké localement
  Future<void> loadPlayer() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      int? storedId = await _playerService.getStoredPlayerId();
      if (storedId != null) {
        PlayerModel? loadedPlayer = await _playerService.getPlayer(storedId);
        if (loadedPlayer != null) {
          _player = loadedPlayer;
        } else {
          await _playerService.deletePlayer(storedId);
          _errorMessage = "Joueur introuvable, veuillez en créer un nouveau.";
        }
      } else {
        _errorMessage = "Aucun joueur enregistré.";
      }
    } catch (e) {
      _errorMessage = "Erreur : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Crée un joueur et le stocke localement
  Future<void> createPlayer(String username) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      PlayerModel? newPlayer = await _playerService.createPlayer(username);
      if (newPlayer != null) {
        _player = newPlayer;
        await loadPlayer(); // 🔹 Recharge immédiatement les données du joueur
      } else {
        _errorMessage = "Échec de la création du joueur.";
      }
    } catch (e) {
      _errorMessage = "Erreur : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}