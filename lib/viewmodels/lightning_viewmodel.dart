import 'package:flutter/material.dart';
import '../models/lightning_model.dart';

class LightningViewModel extends ChangeNotifier {
  final LightningModel _lightningModel;
  bool _isAnimating = true;

  LightningViewModel({required LightningModel lightningModel})
      : _lightningModel = lightningModel;

  String get animationPath => _lightningModel.animationPath;

  bool get isAnimating => _isAnimating;

  void toggleAnimation() {
    _isAnimating = !_isAnimating;
    notifyListeners();
  }
}
