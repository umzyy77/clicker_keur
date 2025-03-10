import 'package:flutter/material.dart';
import '../models/lightning_model.dart';
import 'dart:math';

class LightningViewModel extends ChangeNotifier {
  final LightningModel _lightningModel;
  final List<Map<String, dynamic>> _activeLightnings = [];

  LightningViewModel({required LightningModel lightningModel})
      : _lightningModel = lightningModel;

  String get animationPath => _lightningModel.animationPath;

  List<Map<String, dynamic>> get activeLightnings => _activeLightnings;

  void triggerLightning() {
    String id = DateTime.now().millisecondsSinceEpoch.toString(); // ID unique
    double randomX = 250 + Random().nextDouble() * 50; // Variation légère en X

    _activeLightnings.add({
      "id": id,
      "position": Offset(randomX, 300), // Position en haut
    });

    notifyListeners();

    // Supprimer l’éclair après l'animation
    Future.delayed(Duration(milliseconds: 600), () {
      _activeLightnings.removeWhere((lightning) => lightning["id"] == id);
      notifyListeners();
    });
  }
}
