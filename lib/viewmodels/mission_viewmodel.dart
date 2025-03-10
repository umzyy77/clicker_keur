import 'package:flutter/material.dart';
import 'package:untitled1/models/difficulty_model.dart';
import '../models/mission_model.dart';
import '../core/services/mission_service.dart';

class MissionViewModel extends ChangeNotifier {
  final MissionService _missionService = MissionService();
  List<MissionModel> _missions = [];
  MissionModel? _selectedMission;
  int? _missionObjective;
  bool _isLoading = false;
  String? _errorMessage;

  List<MissionModel> get missions => _missions;

  MissionModel? get selectedMission => _selectedMission;

  int? get missionObjective => _missionObjective;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  /// 🔹 Récupère toutes les missions disponibles
  Future<void> loadMissions() async {
    _isLoading = true;
    _errorMessage = null;

    try {
      _missions = await _missionService.getAllMissions();

      print("📜 Missions stockées dans `_missions` : ${_missions.length}");

      if (_missions.isNotEmpty) {
        print("📌 Exemple de mission stockée : ${_missions.first.toJson()}");
      }
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des missions : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }





  /// 🔹 Récupère une mission spécifique
  Future<void> loadMission(int missionId) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      _selectedMission = await _missionService.getMission(missionId);
    } catch (e) {
      _errorMessage =
          "Erreur lors du chargement de la mission : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Récupère l’objectif d’une mission
  Future<void> loadMissionObjective(int missionId) async {
    _isLoading = true;
    _errorMessage = null;

    try {
      _missionObjective = await _missionService.getMissionObjective(missionId);
    } catch (e) {
      _errorMessage =
          "Erreur lors du chargement de l’objectif de mission : ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int?> getMissionClicksRequired(int missionId) async {
    final mission = _missions.firstWhere(
          (m) => m.idMission == missionId,
      orElse: () => MissionModel(
        idMission: -1, // Valeur invalide pour indiquer l'absence
        name: "Inconnue",
        rewardMoney: 0,
        rewardPower: 0,
        difficulty: DifficultyModel(
          idDifficulty: -1,
          label: "Inconnu",
          clicksRequired: 0,
        ),
      ),
    );


    if (mission == null) {
      print("⚠️ Mission introuvable pour l'ID : $missionId");
      return null;
    }

    return await _missionService.getMissionObjective(missionId);
  }

  MissionModel? getMissionById(int missionId) {
    print("🔎 Recherche de la mission ID : $missionId"); // DEBUG
    print("📜 Liste actuelle des missions : ${_missions.map((m) => m.idMission).toList()}"); // Voir les ID

    try {
      return _missions.firstWhere((mission) => mission.idMission == missionId);
    } catch (e) {
      print("❌ Mission introuvable pour l'ID : $missionId");
      return null;
    }
  }


}
