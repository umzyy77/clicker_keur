import 'package:flutter/material.dart';
import 'package:untitled1/core/services/mission_service.dart';
import '../models/player_mission_model.dart';
import '../core/services/player_mission_service.dart';

class PlayerMissionViewModel extends ChangeNotifier {
  final PlayerMissionService _playerMissionService = PlayerMissionService();
  List<PlayerMissionModel> _playerMissions = [];
  PlayerMissionModel? _currentMission;
  bool _isLoading = false;
  String? _errorMessage;

  List<PlayerMissionModel> get playerMissions => _playerMissions;
  PlayerMissionModel? get currentMission => _currentMission;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Récupère toutes les missions du joueur
  Future<void> loadPlayerMissions(int playerId) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      _playerMissions = await _playerMissionService.getMissionsForPlayer(playerId);
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des missions : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Démarre une mission pour le joueur
  Future<void> startMission(int playerId, int missionId) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      bool success = await _playerMissionService.startMission(playerId, missionId);
      if (success) {
        await loadPlayerMissions(playerId); // Rafraîchir les missions après le lancement
      } else {
        _errorMessage = "Échec du démarrage de la mission.";
      }
    } catch (e) {
      _errorMessage = "Erreur lors du démarrage de la mission : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Incrémente les clics d’une mission en cours
  Future<bool> incrementMissionClicks(int playerId, int missionId) async {
    try {
      bool success = await _playerMissionService.incrementClicks(playerId, missionId);
      if (success) {
        await loadPlayerMissions(playerId);
        return true;
      } else {
        _errorMessage = "Échec de l'incrémentation des clics.";
        return false;
      }
    } catch (e) {
      _errorMessage = "Erreur lors de l'incrémentation des clics : ${e.toString()}";
      return false;
    } finally {
      notifyListeners();
    }
  }
  /// 🔹 Vérifie si une nouvelle mission a été débloquée
  Future<int?> checkNewlyUnlockedMission(int playerId) async {
    try {
      int? missionId = await _playerMissionService.checkNewlyUnlockedMission(playerId);
      return missionId; // Renvoie l'ID de la mission si elle est débloquée
    } catch (e) {
      _errorMessage = "Erreur lors de la vérification des missions débloquées : ${e.toString()}";
      return null;
    }
  }



}