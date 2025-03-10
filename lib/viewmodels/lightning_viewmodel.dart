import 'package:flutter/material.dart';
import '../models/lightning_model.dart';

class LightningViewModel extends ChangeNotifier {
  final LightningModel _lightningModel;
  final List<String> _activeLightnings = [];

  LightningViewModel({required LightningModel lightningModel})
      : _lightningModel = lightningModel;

  String get animationPath => _lightningModel.animationPath;

  List<String> get activeLightnings => _activeLightnings;

  void triggerLightning() {
    String id = DateTime.now().millisecondsSinceEpoch.toString(); // ID unique

    _activeLightnings.add(id);
    notifyListeners();

    // Supprimer l’éclair après l'animation (600ms)
    Future.delayed(Duration(milliseconds: 600), () {
      _activeLightnings.remove(id);
      notifyListeners();
    });
  }
}
