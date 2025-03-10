import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/services/upgrade_service.dart';
import '../models/upgrade_full_model.dart';
import '../viewmodels/player_viewmodel.dart';

class UpgradeViewModel extends ChangeNotifier {
  final UpgradeService _upgradeService = UpgradeService();
  List<PlayerUpgradeModel> _upgrades = [];
  bool _isLoading = false;
  String? _errorMessage;
  int? _playerId;

  List<PlayerUpgradeModel> get upgrades => _upgrades;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// 🔹 Initialise l'ID du joueur (appelé une seule fois)
  void init(BuildContext context) {
    if (_playerId == null) {
      _playerId = Provider.of<PlayerViewModel>(context, listen: false).player?.idPlayer;
      print("🔍 [UpgradeViewModel] ID Joueur chargé : $_playerId");
    }
  }

  /// 🔹 Charge toutes les améliorations disponibles pour le joueur
  Future<void> loadUpgrades(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      init(context);

      if (_playerId == null) {
        _errorMessage = "Joueur non trouvé.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      print("🔍 [UpgradeViewModel] Chargement des améliorations pour le joueur $_playerId");

      List<PlayerUpgradeModel> upgrades = await _upgradeService.getAllUpgrades(_playerId!);

      if (upgrades.isEmpty) {
        _errorMessage = "Aucune amélioration trouvée.";
        print("⚠️ [UpgradeViewModel] Aucune amélioration reçue !");
      } else {
        _upgrades = upgrades;
        print("✅ [UpgradeViewModel] Améliorations chargées : $_upgrades");
      }
    } catch (e) {
      _errorMessage = "Erreur lors du chargement des améliorations : ${e.toString()}";
      print("❌ [UpgradeViewModel] Erreur : $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// 🔹 Achète une amélioration
  Future<void> buyUpgrade(BuildContext context, int upgradeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      init(context);

      if (_playerId == null) {
        _errorMessage = "Joueur non trouvé.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      print("🛒 Tentative d'achat de l'upgrade $upgradeId pour le joueur $_playerId");

      bool success = await _upgradeService.buyUpgrade(_playerId!, upgradeId);
      if (success) {
        print("✅ Achat réussi, rechargement des améliorations...");
        await loadUpgrades(context);
      } else {
        _errorMessage = "Échec de l'achat de l'amélioration.";
        print("❌ Échec de l'achat.");
      }
    } catch (e) {
      _errorMessage = "Erreur lors de l'achat : ${e.toString()}";
      print("❌ [UpgradeViewModel] Erreur : $_errorMessage");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
