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

  /// 🔹 Charge le joueur depuis le fichier JSON local
  Future<void> loadPlayer() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PlayerModel? storedPlayer = await _playerService.loadStoredPlayer();
      if (storedPlayer != null) {
        _player = storedPlayer;
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

  /// 🔹 Crée un joueur et met à jour `_player`
  Future<bool> createPlayer(String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      PlayerModel? newPlayer = await _playerService.createPlayer(username);
      if (newPlayer != null) {
        _player = newPlayer;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Échec de la création du joueur.";
      }
    } catch (e) {
      _errorMessage = "Erreur : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  /// 🔹 Supprime un joueur et réinitialise le ViewModel
  Future<void> deletePlayer() async {
    if (_player != null) {
      bool success = await _playerService.deletePlayer(_player!.idPlayer);
      if (success) {
        _player = null;
        notifyListeners();
      }
    }
  }
}