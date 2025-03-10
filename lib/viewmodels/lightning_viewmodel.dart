import 'package:flutter/material.dart';
import '../models/lightning_model.dart';

class LightningViewModel extends ChangeNotifier {
  final LightningModel _lightningModel;
  bool _isAnimating = false;

  LightningViewModel({required LightningModel lightningModel})
      : _lightningModel = lightningModel;

  String get animationPath => _lightningModel.animationPath;
  bool get isAnimating => _isAnimating;

  // Démarrer l'animation d'éclair
  void triggerLightning() {
    _isAnimating = true;
    notifyListeners();
  }

  // Arrêter l'animation après sa durée
  void stopLightning() {
    _isAnimating = false;
    notifyListeners();
  }
}
