import 'package:flutter/material.dart';
import '../models/enemy_model.dart';
import '../services/enemy_service.dart';

class EnemyViewModel extends ChangeNotifier {
  late EnemyModel _enemy;
  bool isLoading = true;
  int level = 1;

  EnemyModel get enemy => _enemy;

  Future<void> fetchEnemy() async {
    try {
      isLoading = true;
      notifyListeners();
      _enemy = await EnemyService.getEnemyByLevel(level);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void attackEnemy(int damage) {
    _enemy.reduceLife(damage);
    notifyListeners();
    if (_enemy.currentLife == 0) {
      nextEnemy();
    }
  }

  void nextEnemy() {
    level++;
    fetchEnemy();
  }
}
